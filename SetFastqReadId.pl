#!/usr/bin/env perl

# Set the read id of a fastq file based on another fastq file.
# Most useful for setting read IDs in case the paired-end file need the same read id

use strict ;
use warnings ;

die "Usage: a.pl source.fq target.fq > output\n" if (@ARGV == 0) ;

open FP1, $ARGV[0] ;
open FP2, $ARGV[1] ;

while (<FP1>)
{
  my $header = $_ ;
  <FP2> ;

  <FP1> ;
  <FP1> ;
  <FP1> ;

  my $seq = <FP2> ;
  my $separator = <FP2> ;
  my $qual = <FP2> ;
  print($header.$seq.$separator.$qual) ;
}

close FP1 ;
close FP2 ;
