# Barotrauma Server Docker

## How to use
This repository includes an example [docker-compose.yml](example/docker-compose.yml) file you can use to setup your server. Keep in mind that you'll need to change the [environment variables](##Environment-variables).

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
