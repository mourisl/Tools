#!/bin/perl

use strict ;

#usage a.pl xxxx.fq flux.pro > ...

# For Mason and flux simulated data set, append the high, med, low expression level to the id field

open FP1, $ARGV[0] ;
open FP2, $ARGV[1] ;

my %txptExp ;
my @cols ;
my $tid ;
my $line ;
my $exp ;


while ( <FP2> )
{
	chomp ;
	@cols = split ;
	$txptExp{$cols[1]} = $cols[4] ;
}

while ( <FP1> )
{
	chomp ;
	$line = $_ ;
	my $category="null" ;
	if ( /contig=([^\s]*)?/ )
	{
		@cols = split /:/, $1 ;
		$tid = $cols[2] ;
		#print $tid, "\n" ;
		$exp = $txptExp{ $tid } ;
		#print $exp, "\n" ;
		if ( $exp >= 0.0001 )
		{
			$category = "high" ;
		}
		elsif ( $exp >= 0.0000005 )
		{
			$category = "medium" ; 
		}
		else
		{
			$category = "low" ;
		}
	}

	print "$line exp=$category\n" ;
	
	$line = <FP1> ;
	print $line ;

	if ( substr( $ARGV[0], -1 ) eq "q" )
	{
		$line = <FP1> ;
		print $line ;

		$line = <FP1> ;
		print $line ;
	}
}

