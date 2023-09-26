#!/usr/bin/env perl

use strict ;
use warnings ;

die "Usage: a.pl input.fq seq qual_c > new.fq\n" if (@ARGV == 0) ;

my $seq = $ARGV[1] ;
my $qual = $ARGV[2] x length($seq) ;

#print($seq."\n".$qual."\n") ;
open FP, $ARGV[0] ;
while (<FP>)
{
  my $name = $_ ;
  chomp $name ;
  my $s = <FP> ;
  my $separator = <FP> ;
  chomp $separator ;
  my $q = <FP> ;
  print "$name\n$seq\n$separator\n$qual\n" ;
}
close FP ;
