#!/bin/sh
#This script is used to add users for TCIL Apna Transport to tcilmail group.
# This script does following things.
# 1.    Adds a user with prepend apna-
# 2.    Changes the group of user to tcilmail and shell to /bin/false
# 3.    Make Maildir directory and set appropriate permissions
# 4.    Sets passwd for user default 'pas123'

ctr=0
for i in $*
do
	ctr=`expr $ctr + 1`
	/usr/sbin/adduser apna-$i -g tcilmail -s /bin/false
	cd /home/apna-$i/
	maildirmake Maildir
	chgrp -R tcilmail Maildir
	owner=`tail -1 /etc/passwd | sed -e 's/:/ : /g' | awk '{ print $5 }'`
	chown -R "$owner" Maildir
	echo pass123 | passwd --stdin apna-$i
	mail $i@apnatransport.com -s "Test Mail from HECL ISGCS" < /scripts/isg_scripts/addusers/firstmail.txt
         cp /scripts/isg_scripts/addusers/.qmail_default /home/apna-$i/.qmail


done
