#!/usr/bin/env bash

set -e

RESOURCES_DIR="tile/resources"

BUILDPACK_VERSION=${BUILDPACK_VERSION:-4.33.0}

# download cloudfoundry buildpack zip
curl -L "https://github.com/DataDog/datadog-cloudfoundry-buildpack/releases/download/$BUILDPACK_VERSION/datadog-cloudfoundry-buildpack.zip" -o $RESOURCES_DIR/datadog-cloudfoundry-buildpack.zip
