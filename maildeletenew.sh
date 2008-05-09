#!/bin/sh
ctr=0
for i in $*
do
ctr=`expr $ctr + 1`
cd /home/$i/Maildir/cur/
rm -f *
done
