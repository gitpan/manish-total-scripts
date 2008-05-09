#!/bin/sh
ctr=0
for i in $*
do
ctr=`expr $ctr + 1`
chgrp -R asian /home/$i
done
