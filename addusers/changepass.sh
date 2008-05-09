#!/bin/sh
#This script is used to add users for GOLDMOHUR to GODREJ group. This
#script does following things.
# 1.    Adds a user with prepend gm-
# 2.    Changes the group of user to GODREJ and shell to /bin/false
# 3.    Make Maildir directory and set appropriate permissions
# 4.    Sets passwd for user default 'password'

ctr=0
for i in `cat godrej`
do
	ctr=`expr $ctr + 1`
	echo animax123 | passwd --stdin $i

done

sleep 2
