#!/usr/env/bin perl

# Print the mapping A that differs as in mapping B

use strict ;
use warnings ;

die "usage: a.pl A.tsv B.tsv\n" if (@ARGV == 0) ;

my %mapA ;
open FP, $ARGV[0] ;
while (<FP>)
{
  chomp ;
  my @cols = split ;
  $mapA{$cols[0]} = $cols[1] ;
}
close FP ;

open FP, $ARGV[1] ;
while (<FP>)
{
  chomp ;
  my @cols = split ;
  print $cols[0], "\t", $mapA{$cols[0]}, "\t", $cols[1], "\n" if (defined $mapA{$cols[0]} && $mapA{$cols[0]} ne $cols[1]) ;
}
close FP ;
