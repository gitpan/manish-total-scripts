# To add qmvc in home directory by inserting .qmail file
# This file does the following things
# 1. It checks whether .qmail file exist in the user home directory or
#  not. If .qmail file doesn't not exist then it will copy .qmail from
#  a .qmail file template.
# 2. If the file exist then it will check for qmvc entry in the .qmail
#    file.
# 3. If the qmvc entry exists in the .qmail file then nothing will be
#    done. If qmvc entry doesn't exist then it will make an entry in the
#    file
# There are few files related to this program
#  a. tempfile:- Output of the scripts and its details.
#  b. tempfile1:-A file which contain the temporary output of .qmail file   
#  c. tempfile2:-A file taht contain qmvc entry 

rm -f tempfile
rm -f tempfile1
tempfile=/scripts/isg_scripts/addusers/qmvc/tempfile
tempfile1=/scripts/isg_scripts/addusers/qmvc/tempfile1
tempfile2=/scripts/isg_scripts/addusers/qmvc/tempfile2
cd /home
for i in `ls /home | grep ^xps-`
do
 echo $i >> $tempfile 
 cat $i/.qmail 
 if [ $? -eq 0 ]; then
  echo " The .qmail file is present in $i " >> $tempfile   
  cat $i/.qmail | grep qmvc | cut -d  "/" -f6 > $tempfile1
  cmp -s $tempfile1 $tempfile2 
  if [ $? -eq 0 ];  then
  echo " The .qmail file of account $i has qmvc entry " >> $tempfile
  else
 echo " The .qmail file of account $i doesn't have qmvc entry " >> $tempfile 
  # the next three steps will make qmvc entry in the .qmail file
  cp  -f /scripts/isg_scripts/addusers/qmvc/qmailtest2 /scripts/isg_scripts/addusers/qmvc/qmailtest
  cat $i/.qmail >> /scripts/isg_scripts/addusers/qmvc/qmailtest
  cp -f /scripts/isg_scripts/addusers/qmvc/qmailtest $i/.qmail
  fi   
  else
   echo " The Account $i doesn't have .qmail file " >> $tempfile 
   cp /scripts/isg_scripts/addusers/qmvc/qmailtest1  $i/.qmail
   echo " the file is copied " >> $tempfile
 fi
done
