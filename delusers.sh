for i in `cat /scripts/user.txt`
do
userdel -r $1
echo user $i deleted
sleep 10
done

