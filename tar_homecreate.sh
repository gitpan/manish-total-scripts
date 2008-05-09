#/bin/sh

tempfile=/home/tar_data/tempfile
Start=$1
End=$2

#REMOVING OLD TEMP FILE.
rm -f $tempfile

echo "Dear ISGCS, " >> $tempfile
echo " " >> $tempfile
echo "The Tar process of /home on Mail Server 221.171.85.12 has been started on " `date` >> $tempfile
echo "The details of tar program is as follows :- " >> $tempfile
echo " " >> $tempfile
echo " Starting tar process of Dir starting from $Start to $End  at " `date` >> $tempfile

#echo starting tar for $Start to $End
echo /home/tar_data/home\_$Start\_to\_$End.tar.gz

tar -cvzf /home/tar_data/home\_$Start\_to\_$End.tar.gz -pP `ls /home|grep -i ^[$Start-$End]|grep -v qmailbackupfile|grep 
-v hughes-virus|grep -v .emacs| grep -v postmaster | grep -v tar_data | grep -v tcil- | grep -v apaintMailbox | grep -v mil- 
| grep -v apna- | grep -v log- | grep -v xps- | grep -v tci- |grep -v anmol- | grep -v isgopr | grep -v jkb-dummy `

if [ $? -eq 0 ]; then
	echo " Tar process completed successfully at " `date` " Size of Tar File is :- " `du -chs /home/tar_data/home\_$Start\_to\_$End.tar.gz|head -n 1`   >> $tempfile
	echo " " >> $tempfile
else
	echo "FAILURE in tar process at " `date` >> $tempfile
	echo " " >> $tempfile
fi

cd /home/tar_data
echo " Initiating Connection to 221.171.85.113 to transfer file .... " `date` >> $tempfile

ftp -n 221.171.85.113 << ABC
quote USER isgopr
quote PASS cmiycan
bin
hash
cd /home/tar_data

mput home\_$Start\_to\_$End.tar.gz
bye
ABC

if [ $? -eq 0 ]; then
	echo " FTP Successfully done .... at " `date` >> $tempfile
else
	echo "FTP FAILED at " `date` >> $tempfile
fi

echo "......................................................" >> $tempfile

echo " " >> $tempfile

echo "PLEASE UNTAR FILES ON DR SERVER......." >> $tempfile
echo " " >> $tempfile
echo "Regards" >> $tempfile
echo "Linux Sub Group" >> $tempfile

mail isgcs@hughes-ecomm.com -s "Tar Process of Home Dir: Mail Server"  < $tempfile
