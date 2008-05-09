#!/bin/sh
#This script is used to add users for Direcway to direcway group. This 
#script does following things.
# 1.    Adds a user with prepend dway-
# 2.    Changes the group of user to direcway and shell to /bin/false
# 3.    Make Maildir directory and set appropriate permissions
# 4.    Sets passwd for user default 'password'

ctr=0
for i in $*
do
	cd /home/dway-$i/
	if [ $? -ne 0 ]; then
	
		ctr=`expr $ctr + 1`
		/usr/sbin/adduser dway-$i -g direcway -s /bin/false
		echo password | passwd --stdin dway-$i
		cd /home/dway-$i/
		maildirmake Maildir
		chgrp -R direcway Maildir
		owner=`tail -1 /etc/passwd | sed -e 's/:/ : /g' | awk '{ print $5 }'`
		chown -R "$owner" Maildir
	
		/usr/sbin/setquota -u -n dway-$i /dev/ida/c0d0p5 5120 5120 0 0
		echo $i@direcwayindia.com >> /var/qmail/control/relaymailfrom-221.171.85.12
		cp /scripts/isg_scripts/addusers/.qmail_dway /home/dway-$i/.qmail
		mail $i@direcwayindia.com -s "Test mail from HECL ISGCS" < /scripts/isg_scripts/addusers/firstmail.txt
	else
		echo Account $i already exixsts....
	fi
done

