#!/bin/sh
curl --connect-timeout 0 --max-time 0 "http://www.polspam.net/sync.php?type=qmail&ver=" -o badmailfrom.polspam 
#mv badmailfrom.polspam badmailfrom
