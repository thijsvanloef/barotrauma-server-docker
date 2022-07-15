#!/bin/sh
set -e
echo "\e[0;32m*****STARTING INSTALL/UPDATE*****\e[0m"
mkdir -p /home/steam/server/barotrauma
chown -R steam:steam /home/steam/server/barotrauma
/home/steam/steamcmd/steamcmd.sh +force_install_dir "/home/steam/server/barotrauma" +login anonymous +app_update 1026340 validate +quit
echo "\e[0;32m*****INSTALL/UPDATE COMPLETE*****\e[0m"
./start.sh