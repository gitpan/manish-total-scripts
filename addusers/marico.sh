#!/bin/sh
#This script is used to add users tfor Marico to maricoin domain. This 
#script does following things.
# 1.     Adds a user with prepend mil-
# 2.	Changes the group of user to maricoin and shell to /bin/false
# 3.	 Make Maildir directory and set appropriate permissions
# 4.	 Set default quota of 5 MB to user's home directory.
# 5.	DSets passwd for user default 'pas123'

ctr=0
for i in $*
do
	ctr=`expr $ctr + 1`
	/usr/sbin/adduser mil-$i -g maricoin -s /bin/false
	echo password | passwd --stdin mil-$i
	cd /home/mil-$i/
	maildirmake Maildir
	chgrp -R maricoin Maildir
	owner=`tail -1 /etc/passwd | sed -e 's/:/ : /g' | awk '{ print $5 }'`
	chown -R "$owner" Maildir
	/usr/sbin/setquota -u -n mil-$i /dev/ida/c0d0p5 5120 5120 0 0
	cp /scripts/isg_scripts/addusers/.qmail_marico /home/mil-$i/.qmail
	echo $i@maricoindia.net >> /var/qmail/control/relaymailfrom-221.171.85.83
	mail $i@maricoindia.net -s "Test mail from HECL ISGCS" < /scripts/isg_scripts/addusers/firstmail.txt
done
