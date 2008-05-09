#!/bin/sh
cd /home
ls -asl | grep maricoin | grep mil- | awk '{ print $10 }' >/scripts/marico/maricopoplist
sh /scripts/marico/maricomailboxsize.sh `cat /scripts/marico/maricopoplist` >/scripts/marico/usage
