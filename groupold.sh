#!/bin/sh
used=`repquota -a -g | grep asian | head -1 | awk '{ print $3 } '`
soft=`repquota -a -g | grep asian | head -1 | awk '{ print $4 } '`
hard=`repquota -a -g | grep asian | head -1 | awk '{ print $5 } '`
if [ $used -le $hard ];then 

echo "Dear SpaceWeb Customer,

This is an Auto generated system message from SpaceWeb Messaging
Server to inform you that the User's Disk Quota has Exceeded. 
Your intendend recipient has too much mail stored in their
mailbox. However a small (1Kb) message will be delivered if you wish to
inform the person you tried to email.

Thanks for your support.

SPACEWEB NMS "
exit 100
else
 echo "ok"
fi 

