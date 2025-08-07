#!/usr/bin/env perl

# List the feature field from the rows labeled with "exon"

use strict ;
use warnings ;

die "Usage: a.pl xxx.gtf feature > yyy.out\n" if (@ARGV == 0) ;

my $feature = $ARGV[1] ;
open FP, $ARGV[0] ;
while (<FP>)
{
  next if (/^#/) ;
  my @cols = split /\t/, $_ ;
  next if ($cols[2] ne "exon") ;

  if ($cols[8] =~ /$feature\s\"(.+?)\"/)
  {
    print $1, "\n" ;
  }
  else
  {
    die "Cannot find $feature in $_" ;
  }
}
close FP ;
