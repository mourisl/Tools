#!/usr/bin/env perl

# Select sequences with specified IDs from a FASTA file.

use strict ;
use warnings ;

die "Usage: a.pl idlist < input.fa > selected.fa\n" if (@ARGV == 0) ;

open FP, $ARGV[0] ;
my %selectedId ;
while (<FP>)
{
  chomp ;
  $selectedId{$_} = 1 ;
}
close FP ;

my $seq ;
my $header = ">" ;
while (<STDIN>)
{
  chomp ;
  if (/^>/)
  {
    if (defined $selectedId{(split /\s/, substr($header, 1))[0]} )
    {
      print "$header\n$seq\n" ;
    }

    $header = $_ ;
    $seq = 0 ;
  }
  else
  {
    $seq .= $_ ;
  }
}
if (defined $selectedId{(split /\s/, substr($header, 1))[0]} )
{
  print "$header\n$seq\n" ;
}
