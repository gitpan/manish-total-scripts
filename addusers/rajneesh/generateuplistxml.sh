#!/bin/sh
#This script is used to generate the xml script for up sites

ctr=0
echo  "<?xml version='1.0'?>" > upsitelist.xml
echo "<sitelist>" >> upsitelist.xml

for i in $*
do
	ctr=`expr $ctr + 1`
	add=`cat sitedetails | grep $i | cut -d ";" -f 2`
	#add=`cut "$sitedet" -d ";" -f 1
	#echo "$ctr",$i,"$sitedet"
	echo "<site>" >> upsitelist.xml
	echo "<no>"$ctr"</no>" >> upsitelist.xml
	echo "<code>"$i"</code>" >> upsitelist.xml
	echo "<add>""$add""</add>" >> upsitelist.xml 
	echo "</site>" >> upsitelist.xml


	#echo $i,"$add" >>upsitelist.xml
	#/usr/sbin/adduser cipl-$i -g cargil -s /bin/false
	#echo password | passwd --stdin cipl-$i
	#cd /home/cipl-$i/
	#maildirmake Maildir
	#chgrp -R cargil Maildir
	#owner=`tail -1 /etc/passwd | sed -e 's/:/ : /g' | awk '{ print $5 }'`
	#chown -R "$owner" Maildir
	#echo $i@cargill.co.in >> /var/qmail/control/relaymailfrom-221.171.85.94
        #mail $i@cargill.co.in -s "Test mail from HECL ISGCS" < /scripts/isg_scripts/addusers/firstmail.txt	
        # cp /scripts/isg_scripts/addusers/.qmail_default /home/cipl-$i/.qmail

done
echo "</sitelist>" >> upsitelist.xml
sleep 2
