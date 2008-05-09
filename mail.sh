#!/bin/sh
ctr=0
for i in $*
do
ctr=`expr $ctr + 1` 
total=`mailq | grep "$i" | wc -l`
if [ $total -gt 0 ];then
echo "pending mails for "$i" are $total"
fi
done
