#!/bin/sh
#This script is used to add users for Direway to idldwge group. This 
#script does following things.
# 1.    Adds a user with prepend idldwge-
# 2.    Changes the group of user to idldwge and shell to /bin/false
# 3.    Make Maildir directory and set appropriate permissions
# 4.    Sets passwd for user default 'pas123'

ctr=0
for i in $*
do
	cd /home/idl-$i
	if [ $? -ne 0 ]; then
	
		ctr=`expr $ctr + 1`
		/usr/sbin/adduser idl-$i -g idldwge -s /bin/false
		echo password | passwd --stdin idl-$i
		cd /home/idl-$i/
		maildirmake Maildir
		chgrp -R idldwge Maildir
		owner=`tail -1 /etc/passwd | sed -e 's/:/ : /g' | awk '{ print $5 }'`
		chown -R "$owner" Maildir
	
		/usr/sbin/setquota -u -n idl-$i /dev/ida/c0d0p5 5120 5120 0 0
		echo $i@dwge.com >> /var/qmail/control/relaymailfrom-221.171.85.12
		cp /scripts/isg_scripts/addusers/.qmail_dwge /home/idl-$i/.qmail
		mail $i@dwge.com -s "Test mail from HECL ISGCS" < /scripts/isg_scripts/addusers/firstmail.txt
	else
		echo Account $i already exixsts....
	fi
done

