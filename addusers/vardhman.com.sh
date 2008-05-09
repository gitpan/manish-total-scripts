#!/bin/sh
#This script is used to add users for Vardhman to Vardhman group. This
#script does following things.
# 1.    Adds a user with prepend nes-
# 2.    Changes the group of user to nestlein and shell to /bin/false
# 3.    Make Maildir directory and set appropriate permissions
# 4.    Sets passwd for user default 'password'

ctr=0
for i in $*
do
	ctr=`expr $ctr + 1`
	/usr/sbin/adduser vmn-$i -g vardhman -s /bin/false
	echo password| passwd --stdin vmn-$i
	cd /home/vmn-$i/
	maildirmake Maildir
	chgrp -R vardhman Maildir
	owner=`tail -1 /etc/passwd | sed -e 's/:/ : /g' | awk '{ print $5 }'`
	chown -R "$owner" Maildir
	echo $i@vardhman.com >> /var/qmail/control/relaymailfrom-221.171.85.84
	mail $i@vardhman.com -s "Test mail from HECL ISGCS" < /scripts/isg_scripts/addusers/firstmail.txt	
	cp /scripts/isg_scripts/addusers/.qmail_vardhman /home/vmn-$i/.qmail
		
done

sleep 2
