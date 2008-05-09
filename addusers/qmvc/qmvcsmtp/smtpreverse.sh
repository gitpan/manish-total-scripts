# To copy the .qmail file for various customers in 
# /scripts/isg_scripts/addusers/qmvc/qmvcsmtp
# This is useful while reverting back

cd /scripts/isg_scripts/addusers/qmvc/qmvcsmtp/$1/
for i in `ls -asl | grep .qmail-$1 | tr -s " " | cut -d " " -f11`
do 
cp -f $i /var/qmail/alias/
chgrp nofiles /var/qmail/alias/$i
done

