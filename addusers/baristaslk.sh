#!/bin/sh
#This script is used to add users for Barista to barista group. This
#script does following things.
# 1.    Adds a user with prepend barslk-
# 2.    Changes the group of user to barista and shell to /bin/false
# 3.    Make Maildir directory and set appropriate permissions
# 4.    Sets passwd for user default 'password'

ctr=0
for i in $*
do
	ctr=`expr $ctr + 1`
	/usr/sbin/adduser barslk-$i -g barista -s /bin/false
	echo password | passwd --stdin barslk-$i
	cd /home/barslk-$i/
	maildirmake Maildir
	chgrp -R barista Maildir
	owner=`tail -1 /etc/passwd | sed -e 's/:/ : /g' | awk '{ print $5 }'`
	chown -R "$owner" Maildir
	cp /scripts/isg_scripts/addusers/.qmail_barista /home/barslk-$i/.qmail
	echo $i@slk.barista.co.in >> /var/qmail/control/relaymailfrom-221.171.85.99
	mail $i@slk.barista.co.in -s "Test mail from HECL ISGCS" < /scripts/isg_scripts/addusers/firstmail.txt
done

sleep 2

