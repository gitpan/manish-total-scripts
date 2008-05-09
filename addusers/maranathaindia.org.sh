#!/bin/sh
#This script is used to add users for Maranathaindia to maranatha group. This 
#script does following things.
# 1.    Adds a user with prepend mar-
# 2.	Changes the group of user to marantha and shell to /bin/false
# 3.	Make Maildir directory and set appropriate permissions
# 4.	Set default quota of 5 MB to user's home directory.
# 5.	Sets passwd for user default 'maranatha'

ctr=0
for i in $*
do
	clear
	echo 
	echo "----------Entry for user mar-$i---------------"
	echo
	ctr=`expr $ctr + 1`
	/usr/sbin/adduser mar-$i -g maranatha -s /bin/false
	echo "User mar-$i created ........"

	echo maranathaindia | passwd --stdin mar-$i
	echo "Changing Home Directory to /home/mar-$i...."
	cd /home/mar-$i/
	echo "Making Maildir format...."
	maildirmake Maildir
	echo "Changing group of Maildir to maranatha for user mar-$i ......"
	chgrp -R maranatha Maildir
	echo "Changing owner of Maildir to mar-$i for user mar-$i........"
	owner=`tail -1 /etc/passwd | sed -e 's/:/ : /g' | awk '{ print $5 }'`
	chown -R "$owner" Maildir
	echo "Setting default quota of 5 MB for user mar-$i ....."
	/usr/sbin/setquota -u -n mar-$i /dev/ida/c0d0p5 5120 5120 0 0
	echo "Copying .qmail file to mar-$i home directory ....."
	cp /scripts/isg_scripts/addusers/.qmail_maranathaindia /home/mar-$i/.qmail
	echo "Making entry for mar-$i@maranathaindia.org in relaymailfrom-221.171.85.12 file ...."
	echo $i@maranathaindia.org >> /var/qmail/control/relaymailfrom-221.171.85.12
	echo "Sending test mail to user mar-$i ....."
	mail $i@maranathaindia.org -s "Test mail from HECL ISGCS" < /scripts/isg_scripts/addusers/firstmail.txt
	echo "---------------------------------------------"
	sleep 2
done
