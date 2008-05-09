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
ctr=`expr $ctr + 1`
#cp -f .qmail /home/$i/
/usr/sbin/adduser idl-$i -g idldwge -s /bin/false
cd /home/idl-$i/
maildirmake Maildir
chgrp -R idldwge Maildir
owner=`tail -1 /etc/passwd | sed -e 's/:/ : /g' | awk '{ print $5 }'`
chown -R "$owner" Maildir
echo pass123 | passwd --stdin idl-$i
done

clear
echo "Please copy .qmail file to respective user's directory. Thanks! ..."
echo
sleep 2

