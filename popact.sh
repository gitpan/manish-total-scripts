#!/bin/sh
ctr=0
ctr1=0
for i in $*
do
ctr=`expr $ctr + 1`
k=$i
for j in `cat q3`
do
ctr1=`expr $ctr1 + 1`
if [ $j = $k ];
then
echo $k >> q4
fi
done
done

