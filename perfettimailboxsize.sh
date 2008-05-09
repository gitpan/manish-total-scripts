#!/bin/sh
ctr=0
for i in $*
do
ctr=`expr $ctr + 1`
size=`du /home/$i/ | tail -1 | awk '{ print $1 }'`
echo "$i::$size KBytes"
done
