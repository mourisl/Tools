#!/bin/perl

use strict ;

die "usage: a.pl xxx.fa num_of_reads>out.fa" if ( @ARGV == 0 ) ;

srand( 17 ) ;

my %output ;

open FP1, $ARGV[0] ;
my @sample ;
my $cnt = 0 ;
while ( <FP1> )
{
	push @sample, $cnt ;
	++$cnt ;
	my $line = <FP1> ;
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
$cnt = 0 ;
my $tag = 0 ;
while ( <FP1> )
{
	my $header = $_ ;
	my $seq = <FP1> ;
	if ( defined $output{ $cnt } )
	{
		print "$header$seq" ;
		++$tag ;
	}
	++$cnt ;
}
close FP1 ;
