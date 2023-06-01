#!/bin/perl


use strict ;
use warnings ;

die "usage: a.pl fq1 fq2\n" if ( @ARGV == 0 ) ; 

open FP1, $ARGV[0] ;
open FP2, $ARGV[1] ;

while ( <FP1> )
{
	my $r1 = $_ ;
	my $r2 = <FP2> ;

	if ( $r1 ne $r2 )
	{
		print "Differ on:\n$r1$r2" ;
		last ;
	}
}
