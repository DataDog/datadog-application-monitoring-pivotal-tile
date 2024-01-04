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
BPM_VERSION=1.2.7

BUILDPACK_NAME=datadog-cloudfoundry-buildpack-$BUILDPACK_VERSION.zip

echo "download $BUILDPACK_NAME"
curl -L "https://github.com/DataDog/datadog-cloudfoundry-buildpack/releases/download/$BUILDPACK_VERSION/$BUILDPACK_NAME" -o $RESOURCES_DIR/datadog-cloudfoundry-buildpack.zip

echo "download bpm-release $BPM_VERSION"
curl -L "https://bosh.io/d/github.com/cloudfoundry/bpm-release?v=$BPM_VERSION" -o $RESOURCES_DIR/bpm-release.tgz
