#!/bin/sh
ctr=0
for i in $*
do
ctr=`expr $ctr + 1`
#/usr/sbin/userdel -r $i
cd /home/$i/Maildir/new/
rm -f *
#echo `pwd`
done
