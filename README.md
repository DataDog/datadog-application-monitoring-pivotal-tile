# Datadog Application Monitoring for PCF

Send Cloud Foundry Application Metrics, Logs and Traces to Datadog!

# Build new Tile Release
## Prerequisite
- Create a new [Datadog Cloud Foundry Buildpack release](https://github.com/DataDog/datadog-cloudfoundry-buildpack/releases)
- Install the [PCF Tile Generator](https://docs.pivotal.io/tiledev/2-2/tile-generator.html) utility.
  - If it is already installed, you can update it `pip install --upgrade tile-generator`

## Build
- Download the latest `datadog-cloudfoundry-buildpack.zip` [release](https://github.com/DataDog/datadog-cloudfoundry-buildpack/releases) into the `tile/resources` folder
- Run `tile build <TILE_VERSION>` (from the `tile` folder) 
  - It will bump the version in the `tile-history.yml` file automatically.
- The tile file `datadog-application-monitoring-*.*.*.pivotal` will be generated into the `product/` folder.

