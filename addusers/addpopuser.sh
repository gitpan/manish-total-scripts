#!/bin/sh
#This script is used to add new pop users. Currently following domains are supported by this script::-
#	1.	cargill.co.in
#	2.	barista.co.in
#	3.	dwge.com
#	4.	maranathaindia.org
#	5.	maricoindia.net
#	6.	nestle-cd.com
#	7.	nestle..co.in
#	8.	 tcil.com
#	9.	tcilapnatransport.com
#	10.	xpscargo.com
#
# To use this script just a#addpopuser <user@domain>
#This script seperatees domain and user from above passed parameter and then cals appropriate shell script to make user of that domain. Rest all the things are taken ycare by the scripts run in backgroud for each user.


if [ $# -ne 1 ]
then
	echo "Invalid number of parametters passed."
	echo "usage: addpopuser <user@domain>"
	exit 99
fi

clear

echo E-mail id :- $1
USERNAME=`echo $1 | cut -d "@" -f 1`
DOMAIN=`echo $1 | cut -d "@" -f 2`
echo User:- $USERNAME   Domain:- $DOMAIN
echo

case $DOMAIN in
	"maricoindia.net" ) 
		echo "Will run script marico.sh..."
		sh marico.sh $USERNAME ;;
	"tcil.com" )
		echo "Will run script tcil..sh..."
		sh tcil.sh $USERNAME ;;
	"tcilapnatransport.com" )
		echo "Will run script tcilapnatransport.sh..."
		sh tcilapnatransport.sh $USERNAME;;
	"xpscargo.com" )
		echo "Will run script xps.sh..."
		sh xps.sh $USERNAME;;
	"barista.co.in" )
		echo "Will run script barista.sh..."
		sh barista.sh $USERNAME;;
	"cargill.co.in" )
		echo "Will run script cargill.sh..."
		sh cargill.sh $USERNAME;;
	"dwge.com" )
		echo "Will run script dwge.sh..."
		sh dwge.sh $USERNAME;;
	"nestle.co.in" )
		echo "Will run script nestle.co.in.sh..."
		sh nestle.co.in.sh $USERNAME;;
	"nestle-cd.com" )
		echo "Will run script nestle-cd.com..."
		sh nestle-cd.com.sh $USERNAME;;
	"maranathaindia.org" )
		echo "Will run script maranathaindia.org.sh..."
		sh maranathaindia.org.sh $USERNAME;;
	*) 
		echo "Sorrry! I cannot find script for the domain specified..";;
esac
