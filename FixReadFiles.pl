#!/usr/bin/env perl

# Combine 

use strict ;
use warnings ;

die "usage: a.pl [gzipped_read_list..] [gzipped_new_filenames]\n" if (@ARGV == 0) ;

my %readIds ;
my $i ;
my $j ;

sub GetReadId
{
  return (split /\s/, $_)[0] ;
}

my $fileCnt = scalar(@ARGV) / 2 ;
for ($i = 0 ; $i < $fileCnt ; ++$i)
{
  open FP, "zcat ".$ARGV[$i]." |" ;
  while (<FP>)
  {
    my $header = $_ ; 
    my $tmp = <FP> ;
    $tmp = <FP> ;
    $tmp = <FP> ;

    ++$readIds{GetReadId($header)} ;
  }
  close FP ;
} 

for ($i = $fileCnt ; $i < 2 * $fileCnt ; ++$i)
{
  open FP, "zcat ".$ARGV[$i - $fileCnt]." |" ;
  open FPout, "| gzip -c > ".$ARGV[$i] ;
  
  while (<FP>)
  {
    my $header = $_ ;
    my $seq = <FP> ;
    my $separator = <FP> ;
    my $qual = <FP> ;

    my $id = GetReadId($header) ;
    if (defined $readIds{$id} && $readIds{$id} == $fileCnt)
    {
      print FPout $header ;
      print FPout $seq ;
      print FPout $separator ;
      print FPout $qual ;
    }
  }
  close FP ;
  close FPout ;
}
