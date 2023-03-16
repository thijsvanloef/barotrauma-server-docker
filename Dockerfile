FROM cm2network/steamcmd:root
LABEL maintainer="thijs@loef.dev"
RUN dpkg --add-architecture i386; apt-get update; apt-get upgrade -y; apt-get install --no-install-recommends -y \
    libgcc1 \
    lib32stdc++6 \
    libicu-dev \
    && apt-get clean autoclean  \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

ENV MOUNTPATH=/barotrauma \
    GAMEPATH=/home/steam/server/barotrauma \
    ENTRYSCRIPT=${SCRIPTPATH}/dockerful-entry.sh \
    SERVERNAME= \
    PASSWORD= \
    PUBLICITY= \
    LANGUAGE= \
    PORT= \
    QUERYPORT= \
    OWNER_STEAMNAME= \
    OWNER_STEAMID= \
    MAX_PLAYERS=
ENV SAVEPATH="${GAMEPATH}/Daedalic Entertainment GmbH/Barotrauma/Multiplayer" \
    MODPATH="${GAMEPATH}/Daedalic Entertainment GmbH/Barotrauma/WorkshopMods/Installed" \
    SCRIPTPATH=${GAMEPATH}/scripts 

COPY ./scripts/* /home/steam/server/
RUN chmod +x /home/steam/server/init.sh /home/steam/server/start.sh

WORKDIR /home/steam/server

EXPOSE 27015 27016
ENTRYPOINT ["/home/steam/server/init.sh"]