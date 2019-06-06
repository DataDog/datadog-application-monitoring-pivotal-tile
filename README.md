# Datadog Application Monitoring for PCF

Send Cloud Foundry Application Metrics, Logs and Traces to Datadog!

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

- Create a new [Datadog Cloud Foundry Buildpack](https://github.com/DataDog/datadog-cloudfoundry-buildpack/releases) release.

## Build

- Download the latest `datadog-cloudfoundry-buildpack.zip` [release](https://github.com/DataDog/datadog-cloudfoundry-buildpack/releases) into the `tile/resources` folder.

- Create the tile by specifying the version. Look at the [tile-history.yml](tile/tile-history.yml) for the latest version that was built.
    ```bash
    tile build <TILE_VERSION>
    ```

The tile (`datadog-application-monitoring-*.*.*.pivotal` file) is available in the `tile/product` folder, and `tile/tile-history.yml` has been automatically updated.
