#!/usr/bin/env bash

set -e

RESOURCES_DIR="tile/resources"

BUILDPACK_VERSION=${BUILDPACK_VERSION:-4.33.0}

# download cloudfoundry buildpack zip
curl -L "https://github.com/DataDog/datadog-cloudfoundry-buildpack/releases/download/$BUILDPACK_VERSION/datadog-cloudfoundry-buildpack.zip" -o $RESOURCES_DIR/datadog-cloudfoundry-buildpack.zip

# install tile-generator
curl -L "https://github.com/cf-platform-eng/tile-generator/releases/download/v14.0.5/tile_linux-64bit" -o tile_linux-64bit
chmod +x tile_linux-64bit
mv tile_linux-64bit /usr/local/bin/tile
