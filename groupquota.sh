#!/bin/sh
ctr=0
for i in $*
do
ctr=`expr $ctr + 1`
repquota -a -g | grep $i | head -1 > abc1
finallist=`awk ' { print $1,$3,$4,$5 } ' abc1 >> abc2`
awk '$4 > 0 { print $1,$2,$3,$4 } ' abc2 > abc3
awk '$4 * .9 < $2 { print $1 } ' abc3 > /scripts/finallist
done
sleep 60
rm -f abc2      
