:#!/bin/sh
#This script is used to add users for TCIL to tcilmail group. This
#script does following things.
# 1.    Adds a user with prepend tcil-
# 2.    Changes the group of user to tcilmail and shell to /bin/false
# 3.    Make Maildir directory and set appropriate permissions
# 4.    Sets passwd for user default 'pas123'

ctr=0
for i in $*
do
#abc=0
#echo /var/qmail/queue/info/$abc/$i
#while [ $abc -lt 20 ]
#do
	rm /var/qmail/queue/info/5/$i
	rm /var/qmail/queue/local/5/$i
	rm /var/qmail/queue/mess/5/$i
	#abc=expr`$abc+1`
#echo $abc
#done
done
sleep 2
