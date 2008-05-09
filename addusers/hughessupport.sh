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
	/usr/sbin/adduser testing-$i -g testing-mailadmin -s /bin/false
	echo password | passwd --stdin testing-$i
	cd /home/testing-$i/
	maildirmake Maildir
	chgrp -R testing-mailadmin Maildir
	owner=`tail -1 /etc/passwd | sed -e 's/:/ : /g' | awk '{ print $5 }'`
	chown -R "$owner" Maildir
	echo $i@hughessupport.com >> /var/qmail/control/relaymailfrom-221.171.85.12
	echo $i@hughessupport.com >> /var/qmail/control/relaymailfrom-221.171.85.81
        mail $i@hughessupport.com -s "Test mail from HECL ISGCS" < /scripts/isg_scripts/addusers/firstmail.txt	
        cp /scripts/isg_scripts/addusers/.qmail_myitq /home/testing-$i/.qmail

done

sleep 2
