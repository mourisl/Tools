#!/bin/usr/env perl

use strict ;
use warnings ;

die "usage: a.pl introns ref.fa anchor_size> anchor.fa" if ( @ARGV == 0 ) ;

my %ref ;
my $chr = "----" ;
my $seq = "" ;
open FP1, $ARGV[1] ;
while ( <FP1> )
{
	chomp ;
	my $line = $_ ;
	if ( /^>/ )
	{
		if ( $seq ne "" )
		{
			$ref{ $chr } = $seq ;
		}
		$chr = substr( $line, 1 ) ;
		$seq = "" ;
	}
	else
	{
		$line = uc( $line );
		$seq .= $line ;
	}
}
$ref{$chr} = $seq ;
close FP1 ;

my $a = 35 ;
if ( defined $ARGV[2] )
{
	$a = $ARGV[2] ;
}

open FP1, $ARGV[0] ;
my $anchorLenL = $a ;
my $anchorLenR = $a ;
#chr17 42839165 42839294 ?
while ( <FP1> )
{
	chomp ;
	my @cols = split ;

	my $chr = $cols[0] ;
	my $s = $cols[1] ;
	my $e = $cols[2] ;

	my $left = substr( $ref{ $chr }, $s - $anchorLenL, $anchorLenL ) ;
	my $right = substr( $ref{ $chr }, $e - 1, $anchorLenR ) ;
	
	my $header = ">".$chr."_".$s."_".$e ;
	my $seq = $left.$right ;
	print "$header\n$seq\n" ;
}
close FP1 ;
