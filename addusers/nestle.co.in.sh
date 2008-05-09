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
 cd /home/nes-$i
        if [ $? -ne 0 ]; then  	

ctr=`expr $ctr + 1`
	/usr/sbin/adduser nes-$i -g nestlein -s /bin/false
 	passwd nes-$i
	cd /home/nes-$i/
	maildirmake Maildir
	chgrp -R nestlein Maildir
	owner=`tail -1 /etc/passwd | sed -e 's/:/ : /g' | awk '{ print $5 }'`
	chown -R "$owner" Maildir
	echo $i@nestle.co.in >> /var/qmail/control/relaymailfrom-221.171.85.12
        cp /scripts/isg_scripts/addusers/.qmail_default /home/nes-$i/.qmail
	mail $i@nestle.co.in -s "Test mail from ISGCS" < /scripts/isg_scripts/addusers/firstmail.txt
fi
done

sleep 2
