# To configure qmvc in smtp account in alias directory
rm -f /scripts/isg_scripts/addusers/qmvc/qmvcsmtp/tempfile
rm -f /scripts/isg_scripts/addusers/qmvc/qmvcsmtp/tempfile1
cd /var/qmail/alias
for i in `ls -asl | grep .qmail-$1 | tr -s " " | cut -d " " -f11`
do
cat $i | grep qmvc
if [ $? -eq 0 ]; then
echo $i >> /scripts/isg_scripts/addusers/qmvc/qmvcsmtp/tempfile
else 
cp -f /scripts/isg_scripts/addusers/qmvc/qmvcsmtp/tempfile2 /scripts/isg_scripts/addusers/qmvc/qmvcsmtp/tempfile1
cat $i >>  /scripts/isg_scripts/addusers/qmvc/qmvcsmtp/tempfile1
cp -f /scripts/isg_scripts/addusers/qmvc/qmvcsmtp/tempfile1 $i
chgrp nofiles $i
fi
done


