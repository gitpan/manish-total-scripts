#!/bin/sh
#This script is used to add users for Nestle to nestlein group. This
#script does following things.
# 1.    Adds a user with prepend nes-
# 2.    Changes the group of user to nestlein and shell to /bin/false
# 3.    Make Maildir directory and set appropriate permissions
# 4.    Sets passwd for user default 'pass123'

ctr=0
for i in $*
do
	ctr=`expr $ctr + 1`
	/usr/sbin/adduser nes-$i -g nestlein -s /bin/false
	echo pass123 | passwd --stdin nes-$i
	cd /home/nes-$i/
	maildirmake Maildir
	chgrp -R nestlein Maildir
	owner=`tail -1 /etc/passwd | sed -e 's/:/ : /g' | awk '{ print $5 }'`
	chown -R "$owner" Maildir
	echo $i@nestle-cd.com >> /var/qmail/control/relaymailfrom-221.171.85.12
	mail $i@nestle-cd.com -s "Test mail from HECL ISGCS" < /scripts/isg_scripts/addusers/firstmail.txt	
	
done

sleep 2
