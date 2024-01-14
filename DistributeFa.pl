#!/bin/perl

# distribute fasta file into multiple files according to sequence ids

use strict ;
use warnings ;

die "Usage: a.pl combined_genomes.fa seqid_to_file.out output_folder\n" if (@ARGV == 0) ;

my $outputFolder = $ARGV[2] ;

my %seqIdToFile ;
open FP, $ARGV[1] ;
while (<FP>)
{
  chomp ;
  my @cols = split ;
  $seqIdToFile{$cols[0]} = $cols[1] ;
}
close FP ;

open FP, $ARGV[0] ;
my $header = "-1";
my $seq = "" ;
my $seqId = "" ;
while (<FP>)
{
  chomp ;
  if (/^>/)
  {
    if ($seq ne "" && defined $seqIdToFile{$seqId})
    {
      open FPout, ">>$outputFolder/".$seqIdToFile{$seqId} ;
      print FPout "$header\n$seq\n" ;
      close FPout ;
    }

    $header = $_ ;
    $seqId = (split /\s/, substr($header,1))[0] ;
    $seq = "" ;
  }
  else
  {
    $seq .= $_ ;
  }
}
close FP ;

if ($seq ne "" && defined $seqIdToFile{$seqId})
{
  open FPout, ">>$outputFolder/".$seqIdToFile{$seqId} ;
  print FPout "$header\n$seq\n" ;
  close FPout ;
}
