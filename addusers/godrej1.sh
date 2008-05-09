#!/bin/sh
#This script is used to add users for Cargill to cargil group. This
#script does following things.
# 1.    Adds a user with prepend cipl-
# 2.    Changes the group of user to cargil and shell to /bin/false
# 3.    Make Maildir directory and set appropriate permissions
# 4.    Sets passwd for user default 'pass123'

ctr=0
for i in $*
do
	ctr=`expr $ctr + 1`
	/usr/sbin/adduser gm-$i -g godrej -s /bin/false
	echo password | passwd --stdin gm-$i
	cd /home/gm-$i/
	maildirmake Maildir
	chgrp -R godrej Maildir
	owner=`tail -1 /etc/passwd | sed -e 's/:/ : /g' | awk '{ print $5 }'`
	chown -R "$owner" Maildir
	echo $i@goldmohur.com >> /var/qmail/control/relaymailfrom-221.171.85.94
        mail $i@goldmohur.com -s "Test mail from HECL ISGCS" < /scripts/isg_scripts/addusers/firstmail.txt	
        cp /scripts/isg_scripts/addusers/.qmail_default /home/gm-$i/.qmail

done

sleep 2
