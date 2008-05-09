#!/bin/sh
#This script is used to add pplpack.com users . This
#script does following things.
# 1.    Adds a user with prepend ppl-
# 2.    Changes the group of user to pplmail and shell to /bin/false
# 3.    Make Maildir directory and set appropriate permissions
# 4.    Sets passwd for user default 'password'

ctr=0
for i in $* 
do
	ctr=`expr $ctr + 1`
	/usr/sbin/adduser ppl-$i -g pplmail -s /bin/false
	echo password |passwd --stdin ppl-$i
	cd /home/ppl-$i/
	maildirmake Maildir
	chgrp -R pplmail Maildir
	owner=`tail -1 /etc/passwd | sed -e 's/:/ : /g' | awk '{ print $5 }'`
	chown -R "$owner" Maildir
         cp /scripts/isg_scripts/addusers/.qmail_default /home/ppl-$i/.qmail
sleep 2
done

