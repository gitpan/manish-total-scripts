#!/usr/local/bin/perl
# http://code.dogmap.org./qmail/#qtraceaddr

use strict;
use Errno;
use File::stat;
use IO::File;
use Memoize;
use POSIX;

sub nvl($$) { return (defined($_[0])? $_[0]: $_[1]); }

my $qmaildir=$ENV{'QMAIL'}=nvl($ENV{'QMAIL'}, '/var/qmail');
my $auto_break=nvl($ENV{'QMAILBREAK'}, '-');
my $auto_usera=nvl($ENV{'QMAILALIAS'}, 'alias');

sub error_temp($ ) {
  foreach my $err (qw(EINTR ENOMEM ETXTBSY EIO ETIMEOUT EWOULDBLOCK EAGAIN
                      EDEADLK EBUSY ENFILE EMFILE EFBIG ENOSPC ENETDOWN
                      ENETUNREACH ENETRESET ECONNABORTED ECONNRESET ENOBUFS
                      ETOOMANYREFS ECONNREFUSED EHOSTDOWN EHOSTUNREACH
                      EPROCLIM EUSERS EDQUOT ESTALE ENOLCK)) {
    if (exists($Errno::{$err}) and $_[0]==*{$Errno::{$err}}{'CODE'}->()) {
      return 1;
    }
  }
  return;
}

sub byte_chr($$) {
  my ($str, $ch)=@_;
  my $i=index($str, $ch);
  if ($i==-1) { $i=length($str); }
  return $i;
}

sub byte_rchr($$) {
  my ($str, $ch)=@_;
  my $i=rindex($str, $ch);
  if ($i==-1) { $i=length($str); }
  return $i;
}

my $control_lines=memoize(sub {
  my ($fn)=@_;
  my $fh=IO::File->new();
  if ($fh->open($qmaildir.'/control/'.$fn, O_RDONLY)) {
    my @lines=$fh->getlines();
    $fh->close();
    foreach my $line (@lines) { $line=~s/[ \t\n]*\z//; }
    return \@lines;
  } elsif ($! == Errno::ENOENT) {
    return undef;
  } else {
    die($!);
  }
});

sub control_readline($ ) {
  my $lines=$control_lines->(@_);
  return (defined($lines)? $lines->[0]: undef);
}

sub control_me() { return control_readline('me'); }

sub control_rldef($$$ ) {
  my ($fn, $flagme, $def)=@_;
  my $line=control_readline($fn);
  if (defined($line)) { return $line; }
  if ($flagme) {
    my $me=control_me();
    if (defined($me)) { return $me; }
  }
  if (defined($def)) { return $def; }
  die('missing control file: ', $fn);
}

sub control_readfile($$$ ) {
  my ($fn, $flagme, $flagneeded)=@_;
  my $lines=$control_lines->($fn);
  if (defined($lines)) { return [grep({ $_!~/^\#/ } @$lines)]; }
  if ($flagme and defined(control_me())) { return [control_me()]; }
  if ($flagneeded) { die('missing control file: ', $fn); }
  return undef;
}

sub control_envnoathost() {
  return control_rldef('envnoathost', 1, 'envnoathost');
}

sub constmap_init($$) {
  my ($lines, $flagcolon)=@_;
  if ($flagcolon) {
    return map({ $_=~/^([^:]*):(.*)\z/; (lc($1) => $2); } @$lines);
  } else {
    return map({ lc($_) => 1 } @$lines);
  }
}

my %maplocals=constmap_init(control_readfile('locals', 1, 1), 0);
my %mappercenthack=
    constmap_init((control_readfile('percenthack', 0, 0) or []), 0);
my %mapvdoms=
    constmap_init((control_readfile('virtualdomains', 0, 0) or []), 1);

my %users_cdb=();
if (-e $qmaildir.'/users/cdb') {
  my $cdbdump=`cdbdump < "\$QMAIL"/users/cdb`;
  if ($?!=0) { die('cdbdump failed: ', $?); }
  while ($cdbdump ne "\n") {
    $cdbdump=~s/^\+([0-9]+),([0-9]+):// or die('malformed cdbdump');
    my ($klen, $dlen)=($1, $2);
    length($cdbdump)>$klen+2+$dlen+1 or die('malformed cdbdump');
    my $key=substr($cdbdump, 0, $klen);
    $cdbdump=substr($cdbdump, $klen);
    $cdbdump=~s/^-\>// or die('malformed cdbdump');
    my $data=substr($cdbdump, 0, $dlen);
    $cdbdump=substr($cdbdump, $dlen);
    $cdbdump=~s/^\n// or die('malformed cdbdump');
    $users_cdb{$key}=$data;
  }
}

my $GETPW_USERLEN=32;

sub userext($ ) {
  my ($localpart)=@_;
  my $extension_idx=length($localpart);
  while (1) {
    if ($extension_idx < $GETPW_USERLEN) {
      if ($extension_idx==length($localpart) or
          substr($localpart, $extension_idx, 1) eq substr($auto_break, 0, 1)) {
        my $username=lc(substr($localpart, 0, $extension_idx));
        $!=0;
        my @pw=getpwnam($username);
        if ($! == Errno::ETXTBSY) { die($!); }
        if (@pw) {
          my ($name, $passwd, $uid, $gid, $quota, $comment, $gcos, $homedir,
              $shell, $expire)=@pw;
          my $st;
          if ($uid==0)  {
            print('user ', $username, " has uid==0, skipping\n");
          } elsif (defined($st=stat($homedir))) {
            if ($st->uid == $uid) {
              my $dash = "";
              if ($extension_idx<length($localpart)) {
                ++$extension_idx;
                $dash = "-";
              }
              return [\@pw, $dash, substr($localpart, $extension_idx)];
            }
          } elsif (error_temp($!)) { die($!); }
        }
      }
    }
    if ($extension_idx==0) { return; }
    --$extension_idx;
  }
}

sub traceaddr($ ) {
  my ($addr)=@_;
  print('input: ', $addr, "\n");
  # qmail-send:rewrite
  my $localpart=$addr;
  my $i=byte_rchr($localpart, '@');
  if ($i==length($localpart)) {
    $localpart.='@'.control_envnoathost();
    print('after envnoathost: ', $localpart, "\n");
  }
  while (exists($mappercenthack{lc(substr($localpart, $i+1,
                                          length($localpart)-$i-1))})) {
    my $j=byte_rchr($localpart, '%');
    if ($j == length($localpart)) { last; }
    $localpart=substr($localpart, 0, $j).'@'.substr($localpart, $j+1, $i-$j-1);
    $i = $j;
  }
  print('after percenthack: ', $localpart, "\n");
  my $at = byte_rchr($localpart,'@');
  if (exists($maplocals{lc(substr($localpart, $at+1))})) {
    print("domain exists in locals\n");
    $localpart=substr($localpart, 0, $at);
  } else {
    my $x=undef;
    for ($i = 0;;++$i) {
      if ($i > length($localpart)) {
        print("accept address for remote delivery\n");
        return;
      }
      if ($i==0 || ($i == $at + 1) || ($i == length($localpart)) ||
          (($i > $at) && (substr($localpart, $i, 1) eq '.'))) {
        $x = $mapvdoms{lc(substr($localpart, $i))};
        if (defined($x)) { last; }
      }
    }
    if (not defined($x) or $x=~/^\0/) {
      print("accept address for remote delivery\n");
      return;
    }
    $localpart=$x.'-'.substr($localpart, 0, $at);
    print('after virtualdomains: ', $localpart, "\n");
  }

  # qmail-lspawn:nughde_get
  my $nughde;
  my $lower='!'.lc($localpart)."\0";
  my $wildchars=$users_cdb{''};
  $i = length($lower);
  my $flagwild = 0;
  do { # i > 0
    if (!$flagwild || ($i == 1) ||
        (byte_chr($wildchars, substr($lower, $i - 1, 1))
         < length($wildchars))) {
      my $key=substr($lower, 0, $i);
      if (exists($users_cdb{$key})) {
        $nughde=$users_cdb{$key};
        $key=~s/^\!//;
        if ($key=~s/\0\z//) { $key='='.$key; }
        else { $key='+'.$key; }
        print('matched users/cdb entry for ', $key, "\n");
        if ($flagwild) { $nughde.=substr($localpart, $i-1); }
        $nughde=~/^([^\0]*)\0([^\0]*)\0([^\0]*)\0([^\0]*)\0([^\0]*)\0([^\0]*)/
            or die('malformed users/cdb entry');
        $nughde=[$1, $2, $3, $4, $5, $6];
        goto got_nughde;
      }
    }
    --$i;
    $flagwild = 1;
  } while ($i);
  print("no entry in users/cdb\n");

  # qmail-getpw
  my $pde=userext($localpart);
  my $default='';
  if (not defined($pde)) {
    my @pw=getpwnam($auto_usera);
    if (@pw) {
      $pde=[\@pw, '-', $localpart];
      $default='default '
    }
  }
  if (not defined($pde)) {
    print("reject address for lack of any entry in /etc/passwd\n");
    return;
  }
  my $pw=shift(@$nughde);
  $nughde=[@{$pw}[0, 2, 3, 7], @$nughde];
  print('matched ', $default, '/etc/passwd entry for ', $nughde->[0]);

  got_nughde:
  my ($name, $uid, $gid, $homedir, $dash, $extension)=@$nughde;
  print('delivering as USER=', $name, ', UID=', $uid, ', GID=', $gid, "\n");
  # qmail-local:qmesearch
  my $safeext=lc($extension);
  $safeext=~y/./:/;
  my $qme=$homedir.'/.qmail'.$dash.$safeext;
  my $st=stat($qme);
  if (not defined($st)) {
    if ($! != Errno::ENOENT) { die($!); }
    print('missing .qmail file:', $qme, "\n");
  } elsif (!S_ISREG($st->mode)) {
    print('not a regular file:', $qme, "\n");
  } else {
    print('deliver according to ', $qme, "\n");
    return;
  }
  for ($i = length($safeext);$i >= 0;--$i) {
    if (!$i || (substr($safeext, $i - 1, 1) eq '-')) {
      $qme=$homedir.'/.qmail'.$dash.substr($safeext, 0, $i).'default';
      my $st=stat($qme);
      if (not defined($st)) {
        if ($! != Errno::ENOENT) { die($!); }
        print('missing .qmail file:', $qme, "\n");
      } elsif (!S_ISREG($st->mode)) {
        print('not a regular file:', $qme, "\n");
      } else {
        print('deliver according to ', $qme, "\n");
        return;
      }
    }
  }
  if ($dash eq '') {
    print("deliver according to default delivery instructions\n");
  } else {
    print("bounce message due to lack of a .qmail file\n");
  }
}

foreach my $addr (@ARGV) { traceaddr($addr); print("\n"); }


