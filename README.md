[![Docker Build](https://img.shields.io/docker/cloud/build/lucasheld/telerising-api)](https://hub.docker.com/r/lucasheld/telerising-api)
[![Docker Image Size](https://img.shields.io/docker/image-size/lucasheld/telerising-api/latest)](https://hub.docker.com/r/lucasheld/telerising-api)
[![Docker Pulls](https://img.shields.io/docker/pulls/lucasheld/telerising-api)](https://hub.docker.com/r/lucasheld/telerising-api)

telerising-api-docker
=====================
Docker container for [telerising-api](https://github.com/sunsettrack4/telerising-api) based on alpine.

## Usage

### docker-compose
```yaml
---
version: "2.1"
services:
  telerising-api:
    image: lucasheld/telerising-api
    container_name: telerising-api
    restart: unless-stopped
    ports:
      - 5000:5000
    environment:
      - PUID=1000
      - PGID=1000
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /path/to/config:/config
```

### docker cli

```bash
docker run -d \
  --name=telerising-api \
  --restart unless-stopped \
  -p 5000:5000 \
  -e PUID=1000 \
  -e PGID=1000 \
  -v /etc/localtime:/etc/localtime:ro \
  -v /path/to/config:/config \
  lucasheld/telerising-api
```

## Parameters

| Parameter | Explanation |
| ---- | --- |
| `-p 5000` | The webinterface port |
| `-e PUID=1000` | The user id that executes the application |
| `-e PGID=1000` | The group Id that executes the application |
| `-v /config` | The application config folder |
| `-v /etc/localtime` | The container localtime |
