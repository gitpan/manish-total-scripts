#!/bin/sh
#This script is used to add users for Perfettiindia to  perfetti group. This
#script does following things.
# 1.    Adds a user with prepend pil-
# 2.    Changes the group of user to perfetti and shell to /bin/false
# 3.    Make Maildir directory and set appropriate permissions
# 4.    Sets passwd for user default 'password'

ctr=0
for i in $*
do
	ctr=`expr $ctr + 1`
	/usr/sbin/adduser pil-$i -g perfetti -s /bin/false
	echo radix9991 | passwd --stdin pil-$i
	cd /home/pil-$i/
	maildirmake Maildir
	chgrp -R perfetti Maildir
	owner=`tail -1 /etc/passwd | sed -e 's/:/ : /g' | awk '{ print $5 }'`
	chown -R "$owner" Maildir
	echo $i@perfettiindia.com >> /var/qmail/control/relaymailfrom-221.171.85.83
	mail $i@perfettiindia.com -s "Test mail from HECL ISGCS" < /scripts/isg_scripts/addusers/firstmail.txt	
	cp /scripts/isg_scripts/addusers/.qmail_default /home/pil-$i/.qmail
		
done

sleep 2
