#!/bin/sh
#This script is used to add users for TCIL Apna Transport to tcilmail group.
# This script does following things.
# 1.    Adds a user with prepend mil-
# 2.    Changes the group of user to maricoin and shell to /bin/false
# 3.     Make Maildir directory and set appropriate permissions
# 4.     Set default quota of 5 MB to user's home directory.
# 5.    DSets passwd for user default 'pas123'

ctr=0
for i in $*
do
ctr=`expr $ctr + 1`
#cp -f .qmail /home/$i/
/usr/sbin/adduser apna-$i -g tcilmail -s /bin/false
cd /home/apna-$i/
maildirmake Maildir
chgrp -R tcilmail Maildir
owner=`tail -1 /etc/passwd | sed -e 's/:/ : /g' | awk '{ print $5 }'`
chown -R "$owner" Maildir
passwd apna-$i
done
