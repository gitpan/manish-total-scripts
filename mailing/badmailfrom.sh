#!/bin/sh
lynx -source http://libertas.wirehub.net/spamlist.txt | perl -n -e 'if (/IP/) {next;}; s/\t.*//; if(!/@/) {$_ = "@".$_;}; print;' > /var/qmail/control/badmailfrom.external
cd /var/qmail/control
#cp badmailfrom.external badmailfrom.check

