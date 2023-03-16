#!/bin/sh
echo "\e[0;32m*****STARTING INSTALL/UPDATE*****\e[0m"
mkdir -p /home/steam/server/barotrauma
chown -R steam:steam /home/steam/server/barotrauma
/home/steam/steamcmd/steamcmd.sh +force_install_dir "/home/steam/server/barotrauma" +login anonymous +app_update 1026340 validate +quit
echo "\e[0;32m*****INSTALL/UPDATE COMPLETE*****\e[0m"

mkdir -p "${MOUNTPATH}/config"
mkdir -p "${MOUNTPATH}/submarines"
mkdir -p "${MOUNTPATH}/saves"

CLIENTPERM_TEMPLATE=/home/steam/server/clientpermissions_template.xml
SERVERSETT_TEMPLATE=/home/steam/server/serversettings_template.xml

SERVERSETTINGS=${GAMEPATH}/serversettings.xml
PLAYERSETTINGS=${GAMEPATH}/config_player.xml
CLIENTPERM=${GAMEPATH}/Data/clientpermissions.xml

MNT_SERVERSETTINGS=${MOUNTPATH}/config/serversettings.xml
MNT_PLAYERSETTINGS=${MOUNTPATH}/config/config_player.xml
MNT_CLIENTPERM=${MOUNTPATH}/config/clientpermissions.xml

# Config for the serversettings.xml
if [ ! -f "${MNT_SERVERSETTINGS}" ] ; then
    cp "${SERVERSETT_TEMPLATE}" "${MNT_SERVERSETTINGS}"
    echo "\e[0;32m*****CREATING SERVERSETTINGS.XML:*****\e[0m"
    if [ -n "${SERVERNAME}" ] ; then
        echo "SERVERNAME=${SERVERNAME}"
        sed -i "s/name=.*/name=\"${SERVERNAME}\"/" "${MNT_SERVERSETTINGS}"
    fi ;
    if [ -n "${PASSWORD}" ] ; then
        echo "PASSWORD=redacted"
        sed -i "s/password=.*/password=\"${PASSWORD}\"/" "${MNT_SERVERSETTINGS}"
    fi ;
    if [ -n "${PUBLICITY}" ] ; then
        echo "PUBLICITY=${PUBLICITY}"
        sed -i "s/public=.*/public=\"${PUBLICITY}\"/" "${MNT_SERVERSETTINGS}"
    fi ;
    if [ -n "${PORT}" ] ; then
        echo "PORT=${PORT}"
        sed -i "s/port=.*/port=\"${PORT}\"/" "${MNT_SERVERSETTINGS}"
    fi ;
    if [ -n "${QUERYPORT}" ] ; then
        echo "QUERYPORT=${QUERYPORT}"
        sed -i "s/queryport=.*/queryport=\"${QUERYPORT}\"/" "${MNT_SERVERSETTINGS}"
    fi ;
    if [ -n "${MAX_PLAYERS}" ] ; then
        echo "MAX_PLAYERS=${MAX_PLAYERS}"
        sed -i "s/maxplayers=.*/maxplayers=\"${MAX_PLAYERS}\"/" "${MNT_SERVERSETTINGS}"
    fi ;
    
fi ;

if [ ! -f "${MNT_CLIENTPERM}" ] ; then
    echo "\e[0;32m*****CREATING CLIENTPERMISSIONS.XML:*****\e[0m"
    if [ -n "${OWNER_STEAMNAME}" ] && [ -n "${OWNER_STEAMID}" ] ; then
        echo "OWNER_STEAMNAME=${OWNER_STEAMNAME}"
        echo "OWNER_STEAMID=${OWNER_STEAMID}"
        cp "${CLIENTPERM_TEMPLATE}" "${MNT_CLIENTPERM}"
        sed -i "s/name=BARO_OWNER_STEAMNAME/name=\"${OWNER_STEAMNAME}\"/" "${MNT_CLIENTPERM}"
        sed -i "s/steamid=BARO_OWNER_STEAMID/steamid=\"${OWNER_STEAMID}\"/" "${MNT_CLIENTPERM}"
    else 
        cp "${CLIENTPERM}" "${MNT_CLIENTPERM}"
    fi ;
fi ;

if [ ! -f "${MNT_PLAYERSETTINGS}" ] ; then
    echo "\e[0;32m*****CREATING CONFIG_PLAYER.XML:*****\e[0m"
    cp "${PLAYERSETTINGS}" "${MNT_PLAYERSETTINGS}"
fi

rm "${SERVERSETTINGS}"
rm "${CLIENTPERM}"
rm "${PLAYERSETTINGS}"

ln -s "${MNT_SERVERSETTINGS}" "${SERVERSETTINGS}"
ln -s "${MNT_PLAYERSETTINGS}" "${PLAYERSETTINGS}"
ln -s "${MNT_CLIENTPERM}" "${CLIENTPERM}"


mkdir -p "${GAMEPATH}/Submarines/Added/."
mkdir -p "${SAVEPATH}"
mkdir -p "${MODPATH}"

cp -nR "${GAMEPATH}/Submarines/Added/." "${MOUNTPATH}/submarines"
cp -nR "${SAVEPATH}/."                  "${MOUNTPATH}/saves"
cp -nR "${MODPATH}"                     "${MOUNTPATH}/mods"

rm -rf "${GAMEPATH}/Mods"
rm -rf "${GAMEPATH}/Submarines/Added"
rm -rf "${SAVEPATH}"
rm -rf "${MODPATH}"

ln -sf "${MOUNTPATH}/submarines"        "${GAMEPATH}/Submarines/Added"
ln -sf "${MOUNTPATH}/saves"             "${SAVEPATH}"
ln -sf "${MOUNTPATH}/mods"              "${MODPATH}"

./start.sh