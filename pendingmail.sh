#!/bin/sh
touch /scripts/pending
#echo "Dear lokesh" >>/scripts/Pending
echo "Dear ISG Team Members," >>/scripts/pending 
echo "">>/scripts/pending
echo "Below is the pending mails status" >>/scripts/pending
echo "">>/scripts/pending
sh /scripts/mail.sh `cat /scripts/rcpthosts` >>/scripts/pending
echo "">>/scripts/pending
echo "">>/scripts/pending
echo "Regards" >>/scripts/pending
echo "Development Team" >>/scripts/pending
mail isgidc@hughes-ecomm.com -s"Pending mail status on `date`" </scripts/pending
sleep 10
rm -rf /scripts/pending

