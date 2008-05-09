# This script will delete all the mail in the in the postmaster account of the 
# all domains
#

cd /home

rm -rf ./cai-postmaster/Maildir/new/*
echo "CAI DealerConnet Postmaster mail deleted.."
sleep 6
rm -rf ./cipl-postmaster/Maildir/new/*
echo "Cargill Postmaster mails deleted.."
sleep 6
rm -rf ./clm-postmaster/Maildir/new/*
echo "CLM Postmaster mails deleted"
sleep 6
rm -rf ./dway-postmaster/Maildir/new/*
echo "Britania postmaster mails deleted.."
sleep 6
rm -rf ./dwf-postmaster/Maildir/new/*
echo "DWFusion postmaster mail deleted"
sleep 6
rm -rf ./gil-postmaster/Maildir/new/*
echo "Gammon postmaster mails deleted"
sleep 6
rm -rf ./gm-postmaster/Maildir/new/*
echo "Goldmohur postmaster mails deleted.."
sleep 6 
rm -rf ./hecl-postmaster/Maildir/new/*
echo "HECL postmaster mails deleted"
sleep 6
rm -rf ./hughes-postmaster/Maildir/new/*
echo "Hughes postmaster mails deleted.."
sleep 6     
rm -rf ./idl-postmaster/Maildir/new/*
echo "DWGE postmaster mails deleted.."
sleep 6
rm -rf ./jkb-postmaster/Maildir/new/*
echo "JKB postmaster mails deleted.."
sleep 6
rm -rf ./know-postmaster/Maildir/new/*
sleep 6
rm -rf ./nes-postmaster/Maildir/new/*
echo "Nestle postmaster mails deleted.."
sleep 6
rm -rf ./postmaster/Maildir/new/*
echo "postmaster mails deleted.."
sleep 6
rm -rf ./postmasterhecl/Maildir/new/*
sleep 6
rm -rf ./reck-postmaster/Maildir/new/*
echo "Reckitt DB postmaster mails deleted"
sleep 6
rm -rf ./tai-postmaster/Maildir/new/*
echo "taikisha postmaster mails deleted.."
sleep 6
rm -rf ./wor-postmaster/Maildir/new/*
echo "Worli postmaster mails deleted.."
sleep 6

echo "All postmaster mails deleted successfully..."

