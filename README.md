# Barotrauma Server Docker

![Release](https://img.shields.io/github/v/release/thijsvanloef/barotrauma-server-docker)
![Docker Pulls](https://img.shields.io/docker/pulls/thijsvanloef/barotrauma-server-docker)
![Docker Stars](https://img.shields.io/docker/stars/thijsvanloef/barotrauma-server-docker)
![Image Size](https://img.shields.io/docker/image-size/thijsvanloef/barotrauma-server-docker/latest)

[View on Docker Hub](https://hub.docker.com/repository/docker/thijsvanloef/barotrauma-server-docker)

This is a Dockerized version of the [Barotrauma](https://store.steampowered.com/app/602960/Barotrauma/) dedicated server.

## How to use

Keep in mind that you'll need to change the [environment variables](##Environment-variables).

### Docker Compose

This repository includes an example [docker-compose.yml](example/docker-compose.yml) file you can use to setup your server.`

```yml
services:
   barotrauma:
      image: thijsvanloef/barotrauma-server-docker
      restart: unless-stopped
      container_name: barotrauma-server
      ports:
         - 27015:27015/udp
         - 27016:27016/udp
      environment:
         - SERVERNAME=testing # recommended
         - PASSWORD=password # recommended
         - OWNER_STEAMNAME= # recommended
         - OWNER_STEAMID= # recommended
         - MAX_PLAYERS=10 # optional
         - PORT=27015 # optional
         - QUERYPORT=27016 # optional
      volumes:
         - ./barotrauma-test-folder:/barotrauma/
```

### Docker Run

Change every <> to your own configuration

```bash
docker run -d \
    --name barotrauma-server \
    -p 27015:27015/udp \
    -p 27016:27016/udp \
    -v ./<barotrauma-host-folder>:/barotrauma/ \
    -e SERVERNAME=<server-name> \
    -e PASSWORD=password \
    -e OWNER_STEAMNAME=<> \
    -e OWNER_STEAMID=<> \
    -e MAX_PLAYERS=10 \
    -e PORT=27015 \
    -e QUERYPORT=27016 \
    --restart unless-stopped \
    thijsvanloef/barotrauma-server-docker

```

### Volumes

By default the data of the barotrauma server is not persistant, you'll need to create a folder that you can mount in the container. When starting the server, the following folders will be created:

| Folder     | Description                                              |
|------------|----------------------------------------------------------|
| config     | Folder with clientpermissions.xml and serversettings.xml |
| saves      | Folder in which the game saves will be saved             |
| submarines | Folder where you can add custom submarine files          |

### Environment variables

You can use the following values to change the settings of the server on boot.
It is highly recommended you set the following environment values before starting the server:

* OWNER_STEAMNAME
* OWNER_STEAMID
* PASSWORD

| Variable         | Info                                                                | Default Values | Allowed Values |
|------------------|---------------------------------------------------------------------|----------------|----------------|
| OWNER_STEAMNAME* | Steam Username of the server administrator                          | none           | String         |
| OWNER_STEAMID*   | Steam ID of the server administrator                                | none           | String         |
| PUBLICITY        | Setting to make the server visible in the Barotrauma server browser | false          | true/false     |
| SERVERNAME       | Name of the server                                                  | Server         | String         |
| PASSWORD*        | Password used to enter the server (highly recommended)              | none           | String         |
| MAX_PLAYERS      | Maximum amount of players that are able to join simultaniously      | 10             | 1-16           |
| PORT**           | Game Port                                                           | 27015          | 1024-65535     |
| QUERY_PORT**     | Query Port                                                          | 27016          | 1024-65535     |

*highly recommended to set

**advanced users only if you don't run multiple servers, you'll most likely not want to change this

## Reporting Issues/Feature Requests

Issues/Feature requests can be submitted by using [this link](https://github.com/thijsvanloef/barotrauma-server-docker/issues/new/choose).
