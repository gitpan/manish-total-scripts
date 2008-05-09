#!/bin/sh

#rm -f tmp_list
#rm -f NESTLE_SQL_BATCH_FILE
START_DIR="/scripts/isg_scripts/nestle"
USER_ID=$1
echo Script called at`date` by Cpanel. >> /mgulati/nestle_log
echo Configuring user $1 >> /mgulati/nestle_log
echo >> /mgulati/nestle_log

#for  USER in `cat userlist.txt`
#do
###	FOLLOWIN LINES GET USER DETAILS FROM FILE
#	USER_ID=`echo $USER |cut -d":" -f1`
#	PASS=`echo $USER|cut -d ":" -f2`
#	NAME=`echo $USER|tr "_" " " |cut -d ":" -f3`
#
###	FOLLOWING LINES CALCULATE VARIOUS FIELD LENGTH TO BE PUT IN BATCH FILE
#	LEN_NAME=`echo $NAME | wc -c`
#	LEN_NAME=`expr $LEN_NAME - 1`
	
	FROM_ADDR=`echo $USER_ID@nestle.co.in`
	REPLY_ADDR=$FROM_ADDR

	LEN_FROM_ADDR=`echo $FROM_ADDR | wc -c`
	LEN_FROM_ADDR=`expr $LEN_FROM_ADDR - 1`
	LEN_REPLY_ADDR=`echo $REPLY_ADDR | wc -c`
	LEN_REPLY_ADDR=`expr $LEN_REPLY_ADDR - 1`

###	THIS SECTION IS USED TO GENERATE MySQL SBATCH FILE

	SQL_VAL="'a:1:{i:0;a:12:{s:2:\"id\";s:16:\"Default Identity\";s:8:\"fullname\";s:0:\"\";s:9:\"from_addr\";s:$LEN_FROM_ADDR:\"$FROM_ADDR\";s:12:\"replyto_addr\";s:$LEN_REPLY_ADDR:\"$REPLY_ADDR\";s:9:\"signature\";s:0:\"\";s:9:\"sig_first\";i:0;s:10:\"sig_dashes\";i:0;s:14:\"save_sent-mail\";N;s:16:\"sent_mail_folder\";s:10:\"Sent-mails\";s:14:\"save_sent_mail\";s:1:\"1\";s:11:\"private_key\";N;s:16:\"private_key_type\";N;}}'"



	SQL_SCRIPT="insert into horde_prefs (pref_uid,pref_scope,pref_name,pref_value) values ('nes-$USER_ID@nestle-cd.com','horde','identities',$SQL_VAL);"		
#	echo >> $START_DIR/NESTLE_SQL_BATCH_FILE
	echo $SQL_SCRIPT >> $START_DIR/NESTLE_SQL_BATCH_FILE.$USER_ID
	echo "Dear ISGCS,     Please set webmail user preference for nes-$USER_ID. The batch exist in location /scripts/isg_scripts/nestle/NES_BATCH_FILE.$USER_ID.            And also send Welcome mail to user. " | mail -s "Set webmail profile for $USER_ID user " mgulati@hughes-ecomm.com -c isgcs@hughes-ecomm.com 

#done
#!/bin/sh

#for  USER in `ls -l /home/|grep nes-|tr -s " "|cut -d " " -f 9`
#do
#	echo 
#	echo Making record for $USER_ID
#	cd /home/$USER_ID/Maildir/
	cd /home/nes-$USER_ID/Maildir/.Sent-mails
	if [ $? -eq 0 ]; then
		echo USER nes-$USER_ID Sent mail  exists >> /mgulati/nestle_log
	else
		echo USER nes-$USER_ID Sent mail NOT exists >> /mgulati/nestle_log
		maildirmake /home/nes-$USER_ID/Maildir/.Sent-mails
		cp /scripts/isg_scripts/nestle/maildirfolder /home/nes-$USER_ID/Maildir/.Sent-mails/
		chgrp -R nestlein /home/nes-$USER_ID/Maildir/.Sent-mails
		chown -R "nes-$USER_ID" /home/nes-$USER_ID/Maildir/.Sent-mails
	fi
#sleep 3		
#done
