#!/bin/sh

echo "$# argument in all"
ctr=0
for i in $*
do
ctr=`expr $ctr + 1`
#echo $ctr " " $i
#echo hi " " $i
#j=`quota -u $i`
quotafile=`quota -u $i > /scripts/$i`
#lokesh=`tail -1 $i | awk ' { print $3 } ' | grep [0,9]`
user=`tail -1 /scripts/$i | grep [0-9]`
echo $i $user > hello
final=`awk ' $2 == "/dev/ida/c0d0p5" { print $1,$3,$4,$5 } ' hello >> q`
awk '$4 > 0 { print $1,$2,$3,$4,$5 } ' q > users1
awk `$4 * .5 < $2 { print $1 } ' users1 > /scripts/final5
awk '$4 * .8 < $2 { print $1 } ' users1 > /scripts/final
done   
sleep 60
rm -f q
