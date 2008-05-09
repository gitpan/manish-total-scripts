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
	cd /home/gil-$i/
	if [ $? -ne 0 ]; then
	
		ctr=`expr $ctr + 1`
		/usr/sbin/adduser gil-$i -g gammon -s /bin/false
		echo password | passwd --stdin gil-$i
		cd /home/gil-$i/
		maildirmake Maildir
		chgrp -R gammon Maildir
		owner=`tail -1 /etc/passwd | sed -e 's/:/ : /g' | awk '{ print $5 }'`
		chown -R "$owner" Maildir
	
		
		echo $i@gammonindia.com >> /var/qmail/control/relaymailfrom-221.171.85.46
		cp /scripts/isg_scripts/addusers/.qmail_gammon /home/gil-$i/.qmail
		mail $i@gammonindia.com -s "Test mail from HECL ISGCS" < /scripts/isg_scripts/addusers/firstmail.txt
	else
		echo Account $i already exixsts....
	fi
done

