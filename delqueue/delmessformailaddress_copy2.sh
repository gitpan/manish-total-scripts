#!/bin/sh

ctr=0
for i in $*
do

mailq | grep $i | grep GMT | cut -d '#' -f 2 | cut -d ' ' -f 1   >tempoutput2  
sh delmessformailaddress1_copy2.sh `cat tempoutput2`

#rm -f tempoutput

done
sleep 2
