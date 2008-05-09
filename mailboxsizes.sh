#!/bin/sh
ctr=0
ctr1=0
a12=0
for i in $*
do
ctr=`expr $ctr + 1`
ls -asl $i | grep Maidirrsri | awk ' { print $6 } ' >> a7
done
for j in `cat a7`
do
ctr1=`expr $ctr1 + 1`
a12=`expr $a12 + $j`
done
echo $a12
