#!/bin/sh
ctr=0
ctr1=0
for i in $*
do
ctr=`expr $ctr + 1`
for j in `cat a2`
do
ctr1=`expr $ctr1 + 1`
if [ $i <> $j ];
then
echo $j;
break;
else
continue;
fi
done
done

