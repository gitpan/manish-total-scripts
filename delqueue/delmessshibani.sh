#!/bin/sh

ctr=0
for i in $*
do

mailq | grep $i | grep GMT | cut -d '#' -f 2 | cut -d ' ' -f 1   > tempoutputshabani  
sh delmessformailaddress1.sh `cat tempoutputshabani`

#rm -f tempoutput

done
sleep 2
