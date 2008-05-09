#!/bin/sh

ctr=0
for i in $*
do

mailq | grep $i | grep GMT | cut -d '#' -f 2 | cut -d ' ' -f 1   > tempoutputcopy
sh delmessformailaddress1copy.sh `cat tempoutputcopy`

#rm -f tempoutput

done
sleep 2
