# Datadog Application Monitoring for Pivotal Platform

Configuration file for the Datadog Application Monitoring tile for Pivotal Platform.

# Build new tile

## Prerequisite

- Create a virtual environment for installing needed python packages
    ```bash
    cd tile
    virtualenv venv
    source venv/bin/activate
    ```

- Install the [Tile Generator](https://docs.pivotal.io/tiledev/2-5/tile-generator.html) utility on your machine
    ```bash
    pip install tile-generator
    ```
    - If it is already installed, update it with
      ```bash
      pip install --upgrade tile-generator
      ```

- [Build the Datadog Cloud Foundry Buildpack](https://github.com/DataDog/datadog-cloudfoundry-buildpack#building) or download it from the [releases](https://github.com/DataDog/datadog-cloudfoundry-buildpack/releases) page on github.

## Build

- Update `BUILDPACK_VERSION` under `./scripts/prepare.sh`, then run the script to download the desired buildpack.

- Run the build script and pass the desired tile version as follows `VERSION=<TILE_VERSION> ./scripts/build.sh`.

The tile (`datadog-application-monitoring-*.*.*.pivotal` file) is available in the `tile/product` folder, and `tile/tile-history.yml` has been automatically updated.
