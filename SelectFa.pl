#!/usr/bin/env perl

# Select sequences with specified IDs from a FASTA file.

use strict ;
use warnings ;

die "Usage: a.pl idlist [dedup(0)]< input.fa > selected.fa\n" if (@ARGV == 0) ;

open FP, $ARGV[0] ;
my %selectedId ;
while (<FP>)
{
  chomp ;
  $selectedId{$_} = 1 ;
}
close FP ;

my $dedup = 0 ;
$dedup = $ARGV[1] if (defined $ARGV[1]) ;

my $seq = "";
my $header = "" ;
my %usedId ;
my $id ;
while (<STDIN>)
{
  chomp ;
  if (/^>/)
  {
		$id = (split /\s/, substr($header, 1))[0] ;
    if ($header ne "" && defined $selectedId{$id} && 
			($dedup == 0 || !defined $usedId{$id}))
    {
      print "$header\n$seq\n" ;
			$usedId{$id} = 1 ;
    }

    $header = $_ ;
    $seq = "" ;
  }
  else
  {
    $seq .= $_ ;
  }
}
$id = (split /\s/, substr($header, 1))[0] ;
if ($header ne "" && defined $selectedId{$id} && 
			($dedup == 0 || !defined $usedId{$id}))
{
  print "$header\n$seq\n" ;
}
