for i in $* ; do
ipadd=`ifconfig $i    | grep -i inet | cut -d ":" -f 2 | cut -d " " -f 1`

echo $ipadd
done

