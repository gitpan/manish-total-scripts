#!/bin/sh
ctr=0
for i in $*
do
ctr=`expr $ctr + 1`
#cp -f .qmail /home/$i/
/usr/sbin/adduser cipl-$i -g cargil -s /bin/false
cd /home/cipl-$i/
maildirmake Maildir
chgrp -R cargil Maildir
owner=`tail -1 /etc/passwd | sed -e 's/:/ : /g' | awk '{ print $5 }'`
chown -R "$owner" Maildir
passwd cipl-$i
done
