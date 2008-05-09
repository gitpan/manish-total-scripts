
for i in `cat godrejusers`
do
if [ -e /home/$i/.qmail ]; then
cat /home/$i/.qmail | grep quota.sh > temp.txt
cat  /scripts/isg_scripts/temp.txt
if [ -s temp.txt ]; then

echo "quota"
else
echo "No Quota "
fi
else
echo ".qmail file does not exist for the users"
fi

done


