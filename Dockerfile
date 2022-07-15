FROM cm2network/steamcmd:root
LABEL maintainer="thijs@loef.dev"
RUN dpkg --add-architecture i386; apt update; apt upgrade -y; apt install -y \
    libgcc1 \
    lib32stdc++6 \
    libicu-dev 

COPY init.sh start.sh /home/steam/server/
RUN chmod +x /home/steam/server/init.sh /home/steam/server/start.sh

WORKDIR /home/steam/server

EXPOSE 27015 27016
ENTRYPOINT ["./init.sh"]