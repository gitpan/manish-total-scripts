#!/bin/sh
ctr=0
for i in $*
do
ctr=`expr $ctr + 1`
rm -f  /mil-rohk/.qmail
done
