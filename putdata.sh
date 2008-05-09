#! /bin/sh
# Begin putting the data
#k=0
#k=`date | awk '{print $3}'`
#k=`expr $k - 1`
#new=logs_$k
ftp <<**
open 221.171.85.3
cd /home/isgopr/billing
lcd /home/qmailbackupfiles/logs_23
bin
prompt
mput @*
bye
**
# Ending
echo ftp transfer has successfully ended.
