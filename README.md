[![docker build](https://github.com/lucasheld/telerising-api-docker/actions/workflows/main.yml/badge.svg)](https://github.com/lucasheld/telerising-api-docker/actions/workflows/main.yml)
[![latest version](https://ghcr-badge.deta.dev/lucasheld/telerising-api/latest_tag?trim=major&label=latest%20version)](https://github.com/lucasheld/telerising-api-docker/pkgs/container/telerising-api/versions)
[![image size](https://ghcr-badge.deta.dev/lucasheld/telerising-api/size)](https://github.com/lucasheld/telerising-api-docker/pkgs/container/telerising-api)

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
    image: ghcr.io/lucasheld/telerising-api
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
  ghcr.io/lucasheld/telerising-api
```

## Parameters

| Parameter | Explanation |
| ---- | --- |
| `-p 5000` | The webinterface port |
| `-e PUID` | The user id that executes the application |
| `-e PGID` | The group Id that executes the application |
| `-v /config` | The application config folder |
| `-v /etc/localtime` | The container localtime |

The /config volume is primarily used to store the `settings.json` file. However, it can also be used to replace any files in the application folder. All files in /config are automatically symlinked to the application folder. This allows you to overwrite the `providers.json` file, for example:
```
/config
├── app
│   └── static
│       └── json
│           └── providers.json
└── settings.json
```
