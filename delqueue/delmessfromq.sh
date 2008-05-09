#!/bin/sh

ctr=0
for i in $*
do
abc=0

#echo /var/qmail/queue/info/$abc/$i

while [ $abc -lt 23 ]
do
echo $abc,$i
	rm /var/qmail/queue/info/$abc/$i
	rm /var/qmail/queue/local/$abc/$i
	rm /var/qmail/queue/mess/$abc/$i
	if [ $? -gt 0 ]
	then
	    let "abc = abc + 1"
	else
	    let "abc = 25"
	fi
done
done
sleep 2
