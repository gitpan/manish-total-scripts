#!/bin/sh
ctr=0
for i in $*
do

ctr=`expr $ctr + 1`

cd /var/qmail/queue/info/0/
rm -f $i
cd /var/qmail/queue/mess/0/
rm -f $i
cd /var/qmail/queue/remote/0/
rm -f $i

echo done

done
