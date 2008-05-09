#!/bin/sh

mailq|grep remote|grep -v done|cut -d "@" -f 2|sort
