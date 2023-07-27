#!/bin/perl 

use strict ;
use warnings ;

die "usage: a.pl N [alphabets] > XXX\n" if (@ARGV == 0) ; 

my $n = $ARGV[0] ;
my $chr = "ACGT" ; 
$chr = $ARGV[1] if (scalar(@ARGV) >= 2) ;

my $seed = 17 ;
srand($seed) ;

my $seq = "" ;
my $i ;
for ($i = 0 ; $i < $n ; ++$i)
{
  my $c = substr($chr, rand(length($chr)), 1) ;
  $seq .= $c ; 
}
print("$seq\n") ;
