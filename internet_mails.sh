#!/bin/sh
cd /home/qmailbackupfiles/logs_9/
cat testlog | grep msg | grep -v "end msg" | grep -v "new msg" | grep -v "<>" > testlog1
sed -e 's/ /,/g' /home/qmailbackupfiles/logs_9/testlog1 > /home/qmailbackupfiles/logs_9/testlog2
delivery_from=from
for i in `cat /home/qmailbackupfiles/logs_9/testlog2`
do
del=`echo $i | cut -d "," -f7`
echo $del
if [ $del -eq  $delivery_from ]; then
echo $del >>  testlog3
name=`echo $i | cut -d "," -f8`
echo $name >> testlog3
else
name=`echo $i | cut -d "," -f9`
echo $name >> testlog3
fi
done

