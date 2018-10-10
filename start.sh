#!/bin/bash
SOURCE=/config/source

mkdir -p $SOURCE

for FILENAME in VirtualRadar.tar.gz VirtualRadar.WebAdminPlugin.tar.gz VirtualRadar.exe.config.tar.gz VirtualRadar.DatabaseWriterPlugin.tar.gz VirtualRadar.CustomContentPlugin.tar.gz
do
if ! [ -f $SOURCE/$FILENAME ]; then
	curl -o $SOURCE/$FILENAME http://www.virtualradarserver.co.uk/Files/$FILENAME
else
    curl -o $SOURCE/$FILENAME -z $SOURCE/$FILENAME http://www.virtualradarserver.co.uk/Files/$FILENAME
fi
tar -xf $SOURCE/$FILENAME -C /opt/vrs/
done
if ! [ -f $SOURCE/admin_created ]; then
	touch $SOURCE/admin_created
	mono /opt/vrs/VirtualRadar.exe -createAdmin:admin -password:password -nogui
else	
	mono /opt/vrs/VirtualRadar.exe -nogui
fi
