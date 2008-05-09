#!/bin/sh
ctr=0
for i in $*
do
ctr=`expr $ctr + 1`   
echo $i
if [ $i = "asian" ];then
mail $i -c akhurana@hughes-ecomm.com -s "Warning"<<!
Dear SpaceWeb Customer,

This is a Auto generated system message from SpaceWeb Messaging Server to
inform you that the space in your POP Accounts Group with us has been
crossed the 90% limit.

Kindly empty some of the space to avoid any kind of bouncing back of
mails.

Thanks for your support.

SPACEWEB NMS

!
fi
if [ $i = "tannex" ];then
mail akhurana1977@yahoo.com -s "Warning"<<!
Dear Spaceweb Customer,

This is a Auto generated system message from SpaceWeb Messaging Server to
inform you that the space in your POP Account with us has been crossed the
90% limit.

Kindly remove some of the space to avoid any kind of bouncing back of
mails.

Thanks for your support.

SPACEWEB NMS

!
fi
done
