#!/usr/bin/env bash

set -e

# Make the scripts Mac OS / Linux compatible
if uname -a | grep -i "Darwin" >/dev/null 2>&1; then
    shopt -s expand_aliases
    alias sed='gsed'
    alias awk='gawk'
fi

RESOURCES_DIR="tile/resources"

BUILDPACK_VERSION=4.38.0
BUILDPACK_NAME=datadog-cloudfoundry-buildpack-$BUILDPACK_VERSION.zip

echo "download $BUILDPACK_NAME"
curl -L "https://github.com/DataDog/datadog-cloudfoundry-buildpack/releases/download/$BUILDPACK_VERSION/$BUILDPACK_NAME" -o $RESOURCES_DIR/datadog-cloudfoundry-buildpack.zip
