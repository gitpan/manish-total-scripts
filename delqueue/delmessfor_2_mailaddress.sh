#!/bin/sh

ctr=0
for i in $*
do

mailq | grep $i | grep local | cut -d '#' -f 2 | cut -d ' ' -f 1   > tempoutput  
sh delmessformailaddress1.sh `cat tempoutput`

#rm -f tempoutput

done
sleep 2
