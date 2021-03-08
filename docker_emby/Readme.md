## Source docker image
linuxserver/emby \
## AMD driver
amdgpu-pro-20.45-1188099-ubuntu-20.04

## Docker
Compatible with docker-compose v2 schemas.
´´´
---
version: "2.1"
services:
  emby:
    image: gudszent/emby_ryzen
    container_name: emby
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
    volumes:
      - /path/to/library:/config
      - /path/to/tvshows:/data/tvshows
      - /path/to/movies:/data/movies
      - /opt/vc/lib:/opt/vc/lib #optional
    ports:
      - 8096:8096
      - 8920:8920 #optional
    devices:
      - /dev/dri:/dev/dri #optional
      - /dev/vchiq:/dev/vchiq #optional
      - /dev/video10:/dev/video10 #optional
      - /dev/video11:/dev/video11 #optional
      - /dev/video12:/dev/video12 #optional
    restart: unless-stopped
´´´
docker cli
´´´
docker run -d \
  --name=emby \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -p 8096:8096 \
  -p 8920:8920 `#optional` \
  -v /path/to/library:/config \
  -v /path/to/tvshows:/data/tvshows \
  -v /path/to/movies:/data/movies \
  -v /opt/vc/lib:/opt/vc/lib `#optional` \
  --device /dev/dri:/dev/dri `#optional` \
  --device /dev/vchiq:/dev/vchiq `#optional` \
  --device /dev/video10:/dev/video10 `#optional` \
  --device /dev/video11:/dev/video11 `#optional` \
  --device /dev/video12:/dev/video12 `#optional` \
  --restart unless-stopped \
  gudszent/emby_ryzen
´´´



## permission for vga
chmod -R ug+rwX /dev/dri