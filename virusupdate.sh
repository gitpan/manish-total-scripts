#/bin/sh
echo Update server with the latest datfiles
cd /home/isgopr/datfiles/
ftp -n 221.171.85.16 << END
quote user isgopr
quote pass cmiycan
bin
hash
prompt
cd /home/isgopr/datfiles/
mget clean.dat
mget internet.dat
mget names.dat
mget scan.dat
 
END
echo File Transfer completed........

cd /usr/local/uvscan/
echo Taking backup of existing datfies

cp -f clean.dat clean.dat.old
cp -f names.dat names.dat.old
cp -f internet.dat internet.dat.old
cp -f scan.dat scan.dat.old

echo BACKUP OF EXISTING DATFILES COMPLETED

cp -f /home/isgopr/datfiles/clean.dat /usr/local/uvscan/
if [ $? -eq 0 ]; then
echo clean.dat updated....
sleep 2
fi
cp -f /home/isgopr/datfiles/internet.dat /usr/local/uvscan/
if [ $? -eq 0 ]; then
echo internet.dat updated....
sleep 2
fi 
cp -f /home/isgopr/datfiles/scan.dat /usr/local/uvscan/
if [ $? -eq 0 ]; then
echo scan.dat updated....
sleep 2
fi
cp -f /home/isgopr/datfiles/names.dat /usr/local/uvscan/
if [ $? -eq 0 ]; then
echo names.dat updated....
sleep 2
fi
uvscan --version


echo Antivirus datfile updated


