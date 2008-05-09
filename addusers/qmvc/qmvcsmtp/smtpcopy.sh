# To copy the .qmail file for various customers in 
# /scripts/isg_scripts/addusers/qmvc/qmvcsmtp
# This is useful while reverting back

cd /scripts/isg_scripts/addusers/qmvc/qmvcsmtp
mkdir $1
cd /var/qmail/alias
for i in `ls -asl | grep .qmail-$1 | tr -s " " | cut -d " " -f11`
do 
cp $i /scripts/isg_scripts/addusers/qmvc/qmvcsmtp/$1/
chgrp nofiles /scripts/isg_scripts/addusers/qmvc/qmvcsmtp/$1/$i
done

