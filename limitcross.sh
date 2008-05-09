#!/bin/sh
echo "$# argument in all"
ctr=0
for i in $*
do
ctr=`expr $ctr + 1`   
echo $i
mail $i -c isgcs@hughes-ecomm.com -s "Warning - Your Disk Quota has exceeded 80% Limit"<<!
Dear SpaceWeb Customer,

This is a Auto generated system message from SpaceWeb Messaging Server to
inform you that the space in your POP Account with us has been crossed the
80% limit.

Kindly empty some of the space to avoid any kind of bouncing back of
mails.

Thanks for your support.

SPACEWEB NMS

!
done
