#!/bin/sh

ctr=0
for i in `cat okok`
do
mv /home/idl-$i /home/idl-$i.old 
ctr=`expr $ctr + 1`
echo $ctr
echo $i
done
sleep 2

