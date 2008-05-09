#!/bin/sh
#ctr=0
#for i in $*
#do
#ctr=`expr $ctr + 1`
cd /var/qmail/bin/
#rm -f qmail-local
#cp qmail-local-real qmail-local
#cp -f .qmail /home/$i/
#/usr/sbin/adduser bar-$i -g barista -s /bin/false
#cd /home/bar-$i/
#maildirmake Maildir
#chgrp -R barista Maildir
#owner=`tail -1 /etc/passwd | sed -e 's/:/ : /g' | awk '{ print $5 }'`
#chown -R "$owner" Maildir
#passwd xps-$i
done
