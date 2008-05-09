#!/bin/sh
#This script is used to calculate total number of Mail users for a 
#customer. Argument passed to script is the prepend of customer.
#Then script calculates all users for that customer.


#-------Commands Used---------#
wc=/usr/bin/wc
cat=/bin/cat
grep=/bin/grep
cut=/usr/bin/cut
#-----------------------------#

MAILUSER_NUM=`cat /etc/passwd | grep ":$GRP_ID:" | wc -l`

echo
echo Total mail accounts configured for $1 group :- $MAILUSER_NUM
echo
