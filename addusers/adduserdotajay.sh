#!/bin/sh
ctr=0
for i in $*
do
ctr=`expr $ctr + 1`
#/usr/sbin/adduser xps-$i  -s /bin/false
cd /home/wor-$i
maildirmake Maildir
#chgrp -R tcilmail  xps-$i
owner=`cat /etc/passwd |grep $i | sed -e 's/:/ : /g' | awk '{ print $5 }'`
chown -R "$owner" Maildir
chgrp -R popusers Maildir
#passwd xps-$i
done
