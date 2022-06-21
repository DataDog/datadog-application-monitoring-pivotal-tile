#!/usr/bin/env bash

set -e

function setup() {
    echo "--- setting pivnet-cli and access token"

    # download pivnet-cli
    curl -L "https://github.com/pivotal-cf/pivnet-cli/releases/download/v3.0.1/pivnet-linux-amd64-3.0.1" -o ./pivnet
    chmod +x ./pivnet

    ./pivnet login --api-token=$PIVNET_TOKEN

    # refresh token can be obtained from the Tanzu profile under UAA API Token
    ACCESS_TOKEN=$(curl -X POST https://network.tanzu.vmware.com/api/v2/authentication/access_tokens -d '{"refresh_token": "'"$PIVNET_TOKEN"'"}' | jq -r .access_token)
}

function setup_product_token() {
    echo "--- setting up federation token for $PRODUCT_SLUG"
    # setup aws bucket access
    JSON_AWS_RESPONSE=$(curl -X POST https://network.pivotal.io/api/v2/federation_token -H "Authorization: Bearer $ACCESS_TOKEN" -d '{"product_id":"'"$PRODUCT_SLUG"'"}')
    export AWS_ACCESS_KEY_ID=$(echo $JSON_AWS_RESPONSE | jq -r .access_key_id)
    export AWS_SECRET_ACCESS_KEY=$(echo $JSON_AWS_RESPONSE | jq -r .secret_access_key)
    export AWS_BUCKET=$(echo $JSON_AWS_RESPONSE | jq -r .bucket)
    export AWS_REGION=$(echo $JSON_AWS_RESPONSE | jq -r .region)
    export AWS_SESSION_TOKEN=$(echo $JSON_AWS_RESPONSE | jq -r .session_token)
}

function upload_product_file() {
    echo "--- uploading product file"
    # send file to s3 bucket
    AWS_S3_DIRECTORY=$(./pivnet --format=json product -p $PRODUCT_SLUG | jq -r .s3_directory.path)
    AWS_OBJ_KEY="${AWS_S3_DIRECTORY:1}/$FILE_NAME_EXT"

    SHA256=$(sha256sum $FILE_PATH | awk '{print $1}')
    MD5=$(md5sum $FILE_PATH | awk '{print $1}')

    echo  -e "PRODUCT_SLUG:\t\t$PRODUCT_SLUG"
    echo  -e "FILE_NAME:\t\t$FILE_NAME"
    echo  -e "FILE_TYPE:\t\t$FILE_TYPE"
    echo  -e "FILE_VERSION:\t\t$FILE_VERSION"
    echo  -e "FILE_NAME_EXT:\t\t$FILE_NAME_EXT"
    echo  -e "FILE_PATH:\t\t$FILE_PATH"
    echo  -e "AWS_OBJ_KEY:\t\t$AWS_OBJ_KEY"
    echo  -e "SHA256:\t\t\t$SHA256"
    echo  -e "MD5:\t\t\t$MD5"

    if [ "$DRY_RUN" != "true" ]; then
        aws s3 cp $FILE_PATH "s3://$AWS_BUCKET$AWS_S3_DIRECTORY/$FILE_NAME_EXT"
        ./pivnet create-product-file --product-slug=$PRODUCT_SLUG --name=$FILE_NAME --file-type="$FILE_TYPE" --file-version=$FILE_VERSION --sha256=$SHA256 --md5=$MD5 --aws-object-key=$AWS_OBJ_KEY
    fi
}

function publish_monit_tile() {
    echo "--- publishing datadog application monitoring tile"

    # upload .pivotal file
    export PRODUCT_SLUG="datadog-application-monitoring"
    export FILE_NAME="$PRODUCT_SLUG-$VERSION"
    export FILE_TYPE="Software"
    export FILE_VERSION=$VERSION
    export FILE_NAME_EXT=$FILE_NAME.pivotal
    export FILE_PATH=tile/product/$FILE_NAME_EXT

    setup_product_token
    upload_product_file
}

function main() {
    ./scripts/prepare.sh
    ./scripts/release.sh

    LATEST_VERSION=$(tail -n1 tile/tile-history.yml | awk '{print $2}')
    VERSION=${VERSION:-$LATEST_VERSION}

    setup
    publish_monit_tile
}

main "$@"
