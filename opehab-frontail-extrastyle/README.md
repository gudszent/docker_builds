# based on welteki/frontail-openhab docker file (https://raw.githubusercontent.com/welteki/docker_frontail_openhab) !

## openHAB log viewer

Docker image to view your openHAB logs. Runs frontail to stream logs to the browser. Has the openHAB theme applied to it like in [openhabian](https://www.openhab.org/docs/installation/openhabian.html).

![frontail-openhab](https://user-images.githubusercontent.com/16267532/109402637-a7d80580-7957-11eb-8999-d529c96ec520.png)

### Usage

#### Using docker named volumes

If you did set up your openhab container using docker named volumes you can just mount the userdata volume as demonstrated in the following configuration.

```
docker run -d \
  --name frontail-openhab \
  -p 9001:9001 \
  -v openhab_userdata:/openhab/userdata:ro \
  welteki/frontail-openhab:latest
```

#### Mounting log files from host directory

```
docker run -d \
  --name frontail-openhab \
  -p 9001:9001 \
  -v /opt/openhab/userdata/logs:/var/log/openhab:ro \
  welteki/frontail-openhab:latest
```

#### Enabling dark mode

The dark theme can be enabled by setting the `FRONTAIL_THEME` environment variable. To do this just add `-e FRONTAIL_THEME=openhab_dark` to your docker run arguments.

## License

MIT (c) 2018 Han Verstraete https://github.com/welteki
