#/bin/sh
qmHandle -L > /mgulati/dump/qmhandle_log
lsof > /mgulati/dump/lsof_log
tail -n 1000  /var/log/messages > /mgulati/dump/messages_log
QMAIL_LOG=`ls -alt /var/log/qmail/ | head -n 2|tail -n 1  | tr -s " " | cut -d " " -f 9`
echo $QMMAIL_LOG
cp /var/log/qmail/$QMAIL_LOG /mgulati/dump/qmail_log
netstat -tn > /mgulati/dump/netstat_log
ps -ex > /mgulati/dump/ps_log
