#!/bin/perl

use strict ;
use warnings ;

die "usage: a.pl seq < input.fq > new.fq\n" if (@ARGV == 0) ;

my $seq = $ARGV[0] ;

while (<STDIN>)
{
  my $header = $_ ;
  my $inseq = <STDIN> ;
  my $separator = <STDIN> ;
  my $inqual = <STDIN> ;
  my $qual = "F" x length($seq);
  print("$header$seq\n$separator$qual\n") ;
}
