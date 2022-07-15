FROM cm2network/steamcmd:root
LABEL maintainer="thijs@loef.dev"
RUN dpkg --add-architecture i386; apt-get update; apt-get upgrade -y; apt-get install --no-install-recommends -y \
    libgcc1 \
    lib32stdc++6 \
    libicu-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY init.sh start.sh /home/steam/server/
RUN chmod +x /home/steam/server/init.sh /home/steam/server/start.sh

WORKDIR /home/steam/server

EXPOSE 27015 27016
ENTRYPOINT ["./init.sh"]