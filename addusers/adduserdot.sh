#!/bin/sh
ctr=0
for i in $*
do
ctr=`expr $ctr + 1`
#/usr/sbin/adduser $i  -g tcilmail  -s /bin/false
#cd /home/$i
#maildirmake Maildir
#chgrp -R  tcilmail  Maildir
#owner=`tail -1 /etc/passwd | sed -e 's/:/ : /g' | awk '{ print $5 }'`
#chown -R "$owner" Maildir
#chgrp -R tcilmail Maildir
passwd $i
done
