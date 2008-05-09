#!/bin/sh

#script to update Antivirus

ftp -i -v 221.171.85.41 << SCRIPT
binary 
hash 
cd /usr/local/uvscan/
put virus
SCRIPT
