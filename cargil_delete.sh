[root@Spacewebmail /home]# for i in `ls /home |grep ^cipl`
> do
> for z in Dec Mar Apr May Jun Jul Aug Sep Oct Nov 
> do
> for y in `ls -l /home/$i/Maildir/cur/ |grep $z|tr -s " " |cut -d " " -f 9`
> do
> rm -f /home/$i/Maildir/cur/$y
> done
> for a in `ls -l /home/$i/Maildir/new/ |grep $z|tr -s " " |cut -d " " -f 9`
> do
> rm -f /home/$i/Maildir/new/$a
> done
> done
> done
