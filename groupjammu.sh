#!/bin/sh
diff=0
echo="/bin/echo"
cat="/bin/cat"
expr="/usr/bin/expr"
wc="/usr/bin/wc"
used=`repquota -a -g | grep jammu | head -1 | awk '{ print $3 } '`
soft=`repquota -a -g | grep jammu | head -1 | awk '{ print $4 } '`
hard=`repquota -a -g | grep jammu | head -1 | awk '{ print $5 } '`
msgbytes=`$cat - | $wc -c`
msgkb=`$expr $msgbytes / 1024`
msgmb=`$expr $msgkb / 1024`
diff=`$expr $hard - $used`
if [ $msgkb -gt $diff ];then
$echo "Dear SpaceWeb Customer,
This is an Auto generated system message from SpaceWeb Messaging Server to
inform you that the User's Group Disk Quota has Exceeded.
SPACEWEB NMS "
exit 100
fi
if [ $used -gt $hard ];then 
$echo "Dear SpaceWeb Customer,
This is an Auto generated system message from SpaceWeb Messaging Server to
inform you that the User's Disk Quota
has Exceeded. Your intendend recipient has too much mail stored in their
mailbox.
SPACEWEB NMS "
exit 100 
fi


