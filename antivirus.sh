#!/bin/sh
cd /var/qmail/bin
rm -rf qmail-local-real
rm -rf qmail-remote-real
mv qmail-local qmail-local-real
ln -s /usr/sbin/scanmails /var/qmail/bin/qmail-local
mv qmail-remote qmail-remote-real
ln -s /usr/sbin/scanmails /var/qmail/bin/qmail-remote
