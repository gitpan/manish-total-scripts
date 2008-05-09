#!/bin/sh

echo "Pending Mail status as of `date` is as follows:-" > /mgulati/pending_mailstatus_countwise_sorted
echo "-------------------------------------------------------------------">> /mgulati/pending_mailstatus_countwise_sorted  
echo " "


mailq |grep -v done|grep local|cut -d "@" -f 2|sort > mail-q
uniq mail-q > uniq-domain
echo > pending_local_status

for i in `cat uniq-domain`
do
echo -e `fgrep -cx $i mail-q`'\t' pending for '\t'$i >> pending_local_status
done

#sort -nr pending_local_status|mail -s "Pending Mail status local delivery" mgulati@hughes-ecomm.com isgidc@hughes-ecomm.com 
sort -nr pending_local_status > /mgulati/temp


#rm mail-q
#rm uniq-domain
#rm pending_local_status


#for i in `mailq|grep local|grep -v done|cut -d "@" -f 2|sort|uniq`
#do
#	echo `mailq|grep -v done|grep local|grep $i|wc -l` "   "  $i >> /mgulati/pending_mailstatus_countwise
#
#done
#
#sort -nr /mgulati/pending_mailstatus_countwise >> /mgulati/pending_mailstatus_countwise_sorted
#
#mail -s "Pending Mail status countwise for Domains" isgcs@hughes-ecomm.com < /mgulati/pending_mailstatus_countwise_sorted
#
#rm /mgulati/pending_mailstatus_countwise
#rm /mgulati/pending_mailstatus_countwise_sorted

