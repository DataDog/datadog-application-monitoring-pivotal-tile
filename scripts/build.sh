#!/usr/bin/env bash

set -e

pushd tile/

# build product file
tile build $VERSION

popd
