#!/bin/sh

for i in `cat /etc/passwd |cut -d ":" -f 1|grep "-"`
do
USER_NAME=$i

QUOTA_VAL=`quota -u $i | grep "c0d0p5"|grep -v "*"`
if [ "$QUOTA_VAL" != "" ]; then

	HARDLIMIT=`echo $QUOTA_VAL|awk '{print $4}'`
	USAGE=`echo $QUOTA_VAL|awk '{print $2}'`
	USAGE_80=`expr $HARDLIMIT \* 80 / 100`
	USAGE_90=`expr $HARDLIMIT \* 90 / 100`
	USAGE_95=`expr $HARDLIMIT \* 95 / 100`

	if [ $USAGE -gt $USAGE_80 ] ; then
		if [ $USAGE -gt $USAGE_90 ] ; then
			if [ $USAGE -gt $USAGE_95 ]; then
			 mail -s " Your POP account usage exceeds 95% "  $USER_NAME@heclisg.com  < /scripts/isg_scripts/quota/95_%_usage_mail.txt
                        else
			 mail -s " Your POP account usage exceeds 90% "  $USER_NAME@heclisg.com < /scripts/isg_scripts/quota/90_%_usage_mail.txt
                        fi
		else
	                mail -s " Your POP account usage exceeds 80% " $USER_NAME@heclisg.com < /scripts/isg_scripts/quota/80_%_usage_mail.txt
             	fi
	fi


fi
done

