#!/bin/sh
sh /queue/lokesh/date.sh
ls -asl /queue/lokesh/qmailid/* | awk ' { print $10 }' >directory
touch work
echo "Dear SpaceWeb Team Members," >work
echo ""
echo ""
echo "Below is the date wise pending mails status of last 4 days" >>work 
echo ""
echo ""
sh /queue/lokesh/find.sh `cat directory` >>work
echo ""
echo "Regards" >>work
echo "Development Team" >>work
mail lkhanna@hughes-ecomm.com -s"Pending mail status date wise on `date`" <work 
#rm -f work
##rm -f qmailid/*
#rm -f directory
#cd /queue/lokesh/qmailid
#rm -f *
