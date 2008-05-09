#!/bin/sh
#This script is used to add users tfor Marico to maricoin domain. This 
#script does following things.
# 1.     Adds a user with prepend mil-
# 2.	Changes the group of user to maricoin and shell to /bin/false
# 3.	 Make Maildir directory and set appropriate permissions
# 4.	 Set default quota of 5 MB to user's home directory.
# 5.	DSets passwd for user default 'pas123'

ctr=0
#for i in $*
for i in `cat gammonlist1.txt`
do
	echo 'Configuring account' $i
	cp /var/qmail/alias/.qmail-gil-default.old /var/qmail/alias/.qmail-gil-$i
	
done
