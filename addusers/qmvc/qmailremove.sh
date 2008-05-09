# to remove .qmail file from /home from user account

cd /home
for i in `ls /home | grep ^ghcl-`
do
echo $i
rm -f $i/.qmail
done 
