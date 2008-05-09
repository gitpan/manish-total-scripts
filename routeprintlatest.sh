#!/bin/csh
route > /scripts/routeprintlatest
ifconfig |grep 221.171.85|grep -v 221.171.85.12 |cut -d ":" -f 2|awk '{ print $1 }' > /scripts/ipaddrlatest
exit
