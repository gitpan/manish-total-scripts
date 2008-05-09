#!/bin/sh
cd /home
ls -asl | grep pil- | awk '{ print $10 }' >/scripts/perfetti/perfettipoplist
sh /scripts/perfetti/perfettimailboxsize.sh `cat /scripts/perfetti/perfettipoplist`
