#/bin/sh
mkdir /mgulati/dump/output_create_dump1_2002:12:11:45:00
qmHandle -L > /mgulati/dump/output_create_dump1_2002:12:11:45:00/qmhandle_log
lsof > /mgulati/dump/output_create_dump1_2002:12:11:45:00/lsof_log
tail -n 1000  /var/log/messages > 
/mgulati/dump/output_create_dump1_2002:12:11:45:00/messages_log
QMAIL_LOG=`ls -alt /var/log/qmail/ | head -n 2|tail -n 1  | tr -s " " | cut -d " " -f 9`
echo $QMMAIL_LOG
cp /var/log/qmail/$QMAIL_LOG /mgulati/dump/output_create_dump1_2002:12:11:45:00/qmail_log
netstat -tn > /mgulati/dump/output_create_dump1_2002:11:12:30:00/netstat_log
