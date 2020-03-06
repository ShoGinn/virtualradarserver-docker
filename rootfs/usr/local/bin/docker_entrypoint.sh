#!/usr/bin/env bash

SOURCE=/config/source

mkdir -p $SOURCE

for FILENAME in VirtualRadar.tar.gz VirtualRadar.WebAdminPlugin.tar.gz VirtualRadar.exe.config.tar.gz VirtualRadar.DatabaseWriterPlugin.tar.gz VirtualRadar.CustomContentPlugin.tar.gz; do
    if [[ ! -f $SOURCE/$FILENAME ]]; then
        echo "Downloading File: $FILENAME"
        curl -o $SOURCE/$FILENAME http://www.virtualradarserver.co.uk/Files/$FILENAME --silent
    else
        echo "File Exists, checking for newer version: $FILENAME"
        curl -o $SOURCE/$FILENAME -z $SOURCE/$FILENAME http://www.virtualradarserver.co.uk/Files/$FILENAME --silent
    fi

    tar -xf $SOURCE/$FILENAME -C /opt/vrs/

done

if [[ ! -f $SOURCE/admin_created ]]; then
    echo "First Time Run: Admin account created"
    echo "Username: admin"
    echo "Password: password"
    touch $SOURCE/admin_created
    mono /opt/vrs/VirtualRadar.exe -createAdmin:admin -password:password -nogui
else
    mono /opt/vrs/VirtualRadar.exe -nogui
fi
