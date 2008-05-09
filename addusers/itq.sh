#!/bin/sh
#This script is used to add users for GOLDMOHUR to GODREJ group. This
#script does following things.
# 1.    Adds a user with prepend gm-
# 2.    Changes the group of user to GODREJ and shell to /bin/false
# 3.    Make Maildir directory and set appropriate permissions
# 4.    Sets passwd for user default 'password'

ctr=0
for i in $*
do
	ctr=`expr $ctr + 1`
	/usr/sbin/adduser itq-$i -g myitq -s /bin/false
	echo techitq | passwd --stdin itq-$i
	cd /home/itq-$i/
	maildirmake Maildir
	chgrp -R myitq Maildir
	owner=`tail -1 /etc/passwd | sed -e 's/:/ : /g' | awk '{ print $5 }'`
	chown -R "$owner" Maildir
	echo $i@myitq.com >> /var/qmail/control/relaymailfrom-221.171.85.36
	echo $i@myitq.com >> /var/qmail/control/relaymailfrom-221.171.85.81
        mail $i@myitq.com -s "Welcome Mail From ITQ Mail Admin" < /scripts/isg_scripts/addusers/itqfirstmail.txt	
        cp /scripts/isg_scripts/addusers/.qmail_myitq /home/itq-$i/.qmail

done

sleep 2
