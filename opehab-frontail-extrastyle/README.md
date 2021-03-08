# based on welteki/frontail-openhab docker file (https://github.com/welteki/docker_frontail_openhab) and https://community.openhab.org/t/frontail-custom-theme-coloring/116673 !

## openHAB log viewer

Docker image to view your openHAB logs. Runs frontail to stream logs to the browser. Has the openHAB theme applied to it like in [openhabian](https://www.openhab.org/docs/installation/openhabian.html).

![frontail-openhab](https://community-openhab-org.s3.dualstack.eu-central-1.amazonaws.com/optimized/3X/f/c/fcaebc3ca9cb3f182d8d59ef3aa5f322a6fd9a55_2_690x460.jpeg)

### Usage

#### Using docker named volumes

If you did set up your openhab container using docker named volumes you can just mount the userdata volume as demonstrated in the following configuration.

```
docker run -d \
  --name frontail-openhab \
  -p 9001:9001 \
  -v openhab_userdata:/openhab/userdata:ro \
  gudszent/openhab-frontail:latest
```

#### Mounting log files from host directory

```
docker run -d \
  --name frontail-openhab \
  -p 9001:9001 \
  -v /opt/openhab/userdata/logs:/var/log/openhab:ro \
  gudszent/openhab-frontail:latest
```

