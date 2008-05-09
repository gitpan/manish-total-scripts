#!/bin/sh

# Qmail - mailquotacheck
#
# Author: Paul Gregg <pgregg@tibus.net>
# Url: http://www.tibus.net/pgregg/projects/qmail/
# Run this program ala: |mailquotacheck   before your ./Maildir/ or ./Mailbox
# entry in the .qmail file. e.g:
# |/usr/local/bin/mailquotacheck
# ./Maildir/

# Default quota is set to 3000Kb per user, this can be changed below

# You can also install per user quotas which will override the defaults
# by creating a .quota file in the same directory as the .qmail file, e.g:
# echo 10240 > .quota
# this will give that user a 10Mb mail quota

# Individual per message quotas can also be used by creating a file telling
# mailquotacheck that maximum permitted size per email - this is useful
# when you want to allow someone, say, a 20Mb limit but want to prevent emails
# larger than 5Mb. e.g:
# echo 5120 > .maxmsgsize

# Program location defs:
cat="/bin/cat"
expr="/usr/bin/expr"
wc="/usr/bin/wc"
du="/usr/bin/du"
bc="/usr/bin/bc"
cut="/usr/bin/cut"
awk="/usr/bin/awk"
echo="/bin/echo"

# Program defaults
# quota is the default user quota if the user does not have a .quota file
quota=5120
# hardquotabuffer is the 'extra' space allowed for small (<1Kb) messages.
hardquotabuffer=100

# -------------------------------------------------------------------------
# You should not need to change anything below here
# -------------------------------------------------------------------------


# Find out how big the email is in Kb - We don't care about < 1Kb messages.
msgbytes=`$cat - | $wc -c`
ERROR=$?
if [ ${ERROR} -ne 0 ]; then
  # If this fails then you are in trouble ;) - Check program defs at the top.
  $echo "QUOTACHECK ERROR: The mail quotacheck program cannot determine the size of\nthis message. Please inform postmaster of the site you are trying to mail to."
  exit 100
fi
msgkb=`$expr $msgbytes / 1024`
# or you can use:
# msgkb=`$echo $msgbytes / 1024 | $bc`


# Get the users 'home' directory - where there .qmail file is
dir="$HOME"


# Figure out a users mail quota - default is 3000Kb (see above)
# If there is a file '.quota' in their dir then use that value instead.
if [ -f "$dir/.quota" ]; then
  quota=`$cat $dir/.quota 2>/dev/null`
  ERROR=$?
  if [ ${ERROR} -ne 0 ]; then
    $echo "An error occurred while trying to read the recipients quota limit.\nDelivery will be attempted again later."
    exit 111
  fi
fi


# Impose a maximum 'per message' email size.  Use the users quota as standard
# but if there is a file '.maxmsgsize' then use that value.
maxmsgsize=$quota
if [ -f "$dir/.maxmsgsize" ]; then
  maxmsgsize=`$cat $dir/.maxmsgsize`
  ERROR=$?
  if [ ${ERROR} -ne 0 ]; then
    $echo "An error occurred while trying to read the recipients maximum message size.\nDelivery will be attempted again later."
    exit 111
  fi
fi

absquota=`$expr $quota + $hardquotabuffer`

# What is the maildir's current disk usage
du=`$du -sk $dir | $awk {'print $1'}`
ERROR=$?
if [ ${ERROR} -ne 0 ]; then
  $echo "An error occurred while trying to get the user's current quota usage.\nDelivery will be attempted again later."
  exit 111
fi

duwould=`$expr $du + $msgkb`

#debug - mail all these vars to me.
#set | mail pgregg@tibus.net

# Refuse the email if it is too big
if [ $msgkb -gt $maxmsgsize ]; then
  $echo "Sorry, This message is larger than the current maximum message size limit which this user can receive.:\nYour message was $msgkb Kbytes and the maximum is $maxmsgsize Kbytes."
  exit 100
fi

# Check if the user would be above the absolute quota
if [ $duwould -gt $absquota ]; then
  # Ok, we aren't going to deliver this message, lets try and give the sender
  # a decent error message
  if [ $du -gt $quota ]; then
    $echo "User's Disk Quota Exceeded.\nSorry, your message cannot be delivered as the recipient has exceeded\ntheir disk space limit for email."
  else
    $echo "Sorry, Your message cannot be delivered bacause the recipient does not have\nenough disk space left for it.";
  fi
  if [ $du -lt $absquota ]; then
    $echo "\n However, small (< 1Kb) message will be delivered should you wish
    to\ninform the person you tried to email."
  fi
  exit 100
fi

# If the email would put the user over quota, then refuse it (accept < 1Kb)
if [ $msgbytes -gt 1024 ]; then
  if [ $duwould -gt $quota ]; then

    $echo "    User's Disk Quota Exceeded. Sorry, your intendend recipient
    has too much mail stored in their mailbox.
    Your message totalled $msgkb  Kbytes ($msgbytes bytes). 
    However a small (1Kb) message will be delivered if you wish to
    inform the person you tried to email."
    exit 100

  fi
fi

exit 0
