#!/bin/sh
#This script is used to add users for logisticsfocus to logisticsfocus.com  
#domain. This script does following things.
# 1.     Adds a user with prepend log-
# 2.	Changes the group of user to logisticsfocus and shell to /bin/false
# 3.	 Make Maildir directory and set appropriate permissions
# 4.	 Set default quota of 5 MB to user's home directory.
# 5.	DSets passwd for user default 'pas123'

ctr=0
for i in $*
do
	ctr=`expr $ctr + 1`
	/usr/sbin/adduser log-$i -g logisticsfocus -s /bin/false
	echo password | passwd --stdin log-$i
	cd /home/log-$i/
	maildirmake Maildir
	chgrp -R logisticsfocus Maildir
	owner=`tail -1 /etc/passwd | sed -e 's/:/ : /g' | awk '{ print $5 }'`
	chown -R "$owner" Maildir
	cp /scripts/isg_scripts/addusers/.qmail_default /home/log-$i/.qmail
	echo $i@logisticsfocus.com >> /var/qmail/control/relaymailfrom-221.171.85.83
	echo $i@logisticsfocus.com >> /var/qmail/control/relaymailfrom-221.171.85.12
	mail $i@logisticsfocus.com -s "Test mail from HECL ISGCS" < /scripts/isg_scripts/addusers/firstmail.txt
done
