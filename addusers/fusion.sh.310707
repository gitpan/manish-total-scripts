#!/bin/sh
#This script is used to add users for DIRECWAY FUSION to fusion group. This
#script does following things.
# 1.    Adds a user with prepend dwf-
# 2.    Changes the group of user to fusion and shell to /bin/false
# 3.    Make Maildir directory and set appropriate permissions
# 4.    Sets passwd for user default 'password'

ctr=0
for i in $*
do

ctr=`expr $ctr + 1`
/usr/sbin/adduser dwf-$i -g fusion -s /bin/false
echo password | passwd --stdin dwf-$i
cd /home/dwf-$i/
maildirmake Maildir
chgrp -R fusion Maildir
owner=`tail -1 /etc/passwd | sed -e 's/:/ : /g' | awk '{ print $5 }'`
chown -R "$owner" Maildir

/usr/sbin/setquota -u -n dwf-$i /dev/ida/c0d0p5 5120 5120 0 0

echo $i@dwfusion.com >> /var/qmail/control/relaymailfrom-221.171.85.12
echo $i@dwfusion.com >> /var/qmail/control/relaymailfrom-221.171.85.76
echo $i@dwfusion.com >> /var/qmail/control/relaymailfrom-221.171.85.81
mail $i@dwfusion.com -s "Test mail from ISGCS" < /scripts/isg_scripts/addusers/firstmail.txt	
cp /scripts/isg_scripts/addusers/.qmail_fusion /home/dwf-$i/.qmail

done

sleep 2
