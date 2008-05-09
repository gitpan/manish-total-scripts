#!/bin/sh

# 1.    Adds a user with prepend hecl-
# 2.    Changes the group of user to popusers and shell to /bin/false
# 3.    Make Maildir directory and set appropriate permissions
# 4.    Sets passwd for user default 'password'

ctr=0
for i in $*
do
	ctr=`expr $ctr + 1`
	/usr/sbin/adduser hughes-$i -g popusers -s /bin/false
	echo password | passwd --stdin hughes-$i
	cd /home/hughes-$i/
	maildirmake Maildir
	chgrp -R popusers Maildir
	owner=`tail -1 /etc/passwd | sed -e 's/:/ : /g' | awk '{ print $5 }'`
	chown -R "$owner" Maildir
        cp /scripts/isg_scripts/addusers/.qmail_default /home/hughes-$i/.qmail


done

