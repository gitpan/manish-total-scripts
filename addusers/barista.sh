#!/bin/sh
#This script is used to add users for TCIL to tcilmail group. This
#script does following things.
# 1.    Adds a user with prepend tcil-
# 2.    Changes the group of user to tcilmail and shell to /bin/false
# 3.    Make Maildir directory and set appropriate permissions
# 4.    Sets passwd for user default 'pas123'

ctr=0
for i in $*
do
	ctr=`expr $ctr + 1`
	/usr/sbin/adduser bar-$i -g barista -s /bin/false
	echo welcome |passwd --stdin bar-$i
	cd /home/bar-$i/
	maildirmake Maildir
	chgrp -R barista Maildir
	owner=`tail -1 /etc/passwd | sed -e 's/:/ : /g' | awk '{ print $5 }'`
	chown -R "$owner" Maildir
	mail $i@barista.co.in -s "Test Mail from HECL ISGCS" < /scripts/isg_scripts/addusers/firstmail.txt	
        cp /scripts/isg_scripts/addusers/.qmail_default /home/bar-$i/.qmail
	echo $i@barista.co.in >> /var/qmail/control/relaymailfrom-221.171.85.99
#	echo $i@tcil.com >> /var/qmail/control/relaymailfrom-221.171.85.83

done

sleep 2
