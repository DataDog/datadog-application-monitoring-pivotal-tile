#!/usr/bin/env bash

set -e

# Make the scripts Mac OS / Linux compatible
if uname -a | grep -i "Darwin" >/dev/null 2>&1; then
    shopt -s expand_aliases
    alias sed='gsed'
    alias awk='gawk'
fi

RESOURCES_DIR="tile/resources"

BUILDPACK_VERSION=4.36.0

major=$(echo $BUILDPACK_VERSION | cut -d. -f1)
minor=$(echo $BUILDPACK_VERSION | cut -d. -f2)

if [ $major -gt 4 ] || [ $major -eq 4 -a $minor -ge 36 ]; then
    echo "download datadog-cloudfoundry-buildpack-$BUILDPACK_VERSION.zip"
    curl -L "https://github.com/DataDog/datadog-cloudfoundry-buildpack/releases/download/$BUILDPACK_VERSION/datadog-cloudfoundry-buildpack-$BUILDPACK_VERSION.zip" -o $RESOURCES_DIR/datadog-cloudfoundry-buildpack-$BUILDPACK_VERSION.zip

    echo "update tile.yml resource path"
    sed -i -e "s/path:.*/path: resources\/datadog-cloudfoundry-buildpack-$BUILDPACK_VERSION.zip/g" tile/tile.yml
else
    echo "download datadog-cloudfoundry-buildpack.zip"
    curl -L "https://github.com/DataDog/datadog-cloudfoundry-buildpack/releases/download/$BUILDPACK_VERSION/datadog-cloudfoundry-buildpack.zip" -o $RESOURCES_DIR/datadog-cloudfoundry-buildpack.zip
fi
