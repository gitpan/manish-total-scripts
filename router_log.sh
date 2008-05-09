#!/bin/bash
DIR=/mgulati

IP=202.134.192.6
echo $IP

(echo "isgopr"; 
echo "slazenger";
echo "show version";   
echo " " ;
echo " " ;
echo " " ;
echo " " ;
echo "show mprocesses cpu";
echo " ";
echo " ";
echo " ";
echo " ";
echo "quit";
sleep 5 ) | telnet $IP > $DIR/routertest 2> $DIR/router_err

