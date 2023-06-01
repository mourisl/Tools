#!/bin/perl

use strict ;

die "a.pl xxx.fq > yyy.fq\n" if ( @ARGV == 0 ) ;

open FP1, $ARGV[0] ;

while ( <FP1> )
{
	my $line ;
	my $head = $_ ;
	print $head ;
	chomp $head ;
	if ( $head =~ /haplotype_infix=(.*?)\s/ )
	{
		print $1, "\n" ;
	}
	else
	{
		die "Unknown format $head\n" ;
	}

	$line = <FP1> ;
	$line = <FP1> ;
	print $line ;
	$line = <FP1> ;
	print $line ;
}
