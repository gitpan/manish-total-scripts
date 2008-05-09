#!/bin/sh
#This script is used to add users for GHCL to ghclindia group. This
#script does following things.
# 1.    Adds a user with prepend hub-
# 2.    Changes the group of user to ghclindia and shell to /bin/false
# 3.    Make Maildir directory and set appropriate permissions
# 4.    Sets passwd for user default 'pas123'

ctr=0
for i in $*
do
	ctr=`expr $ctr + 1`
	/usr/sbin/adduser hub-$i -g ghclindia -s /bin/false
	echo password |passwd --stdin hub-$i
	cd /home/hub-$i/
	maildirmake Maildir
	chgrp -R ghclindia Maildir
	owner=`tail -1 /etc/passwd | sed -e 's/:/ : /g' | awk '{ print $5 }'`
	chown -R "$owner" Maildir
	mail $i@ghclindia.com -s "Test Mail from HECL ISGCS" < /scripts/isg_scripts/addusers/firstmail.txt	
         cp /scripts/isg_scripts/addusers/.qmail_default /home/hub-$i/.qmail
	echo $i@ghclindia.com >> /var/qmail/control/relaymailfrom-221.171.85.12

done

sleep 2
