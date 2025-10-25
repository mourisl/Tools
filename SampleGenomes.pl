#!/bin/perl

# Sample genomes from a genome collection
# support multiline 

use strict ;

die "usage: a.pl xxx.fa num_of_genomes>out.fa" if ( @ARGV == 0 ) ;

srand( 17 ) ;

my %output ;

open FP1, $ARGV[0] ;
my @sample ;
my $cnt = 0 ;
while ( <FP1> )
{
  if (/^>/)
  {
    push @sample, $cnt ;
    ++$cnt ;
  } 
}
close FP1 ;

my $i ;
my $n = $ARGV[1] ;
for ( $i = 0 ; $i < $n ; ++$i )
{
	my $r = int( rand( $cnt - $i ) ) ;
	my $tmp = $sample[ $i ] ;
	$sample[$i] = $sample[ $i + $r ] ;
	$sample[ $i + $r ] = $tmp ;
	#print $sample[$i], " ", $r, " ", $sample[$i + $r], "\n" ;

	$output{ $sample[$i] } = 1 ;
}

open FP1, $ARGV[0] ;
$cnt = -1 ;
my $seq ;
my $header = "" ;
while ( <FP1> )
{
  if (/^>/)
  {
    print "$header$seq\n" if ( defined $output{ $cnt } ) ;
    $header = $_ ;
    $seq = "" ;
    ++$cnt ;
  }
  else
  {
    chomp ;
    $seq .= $_ ;
  }
}
close FP1 ;
print "$header$seq\n" if ( defined $output{ $cnt } ) ;
