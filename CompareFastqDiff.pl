#!/bin/perl

use strict ;

die "usage: a.pl xxxx.fq yyy.fq\n" if ( @ARGV == 0 ) ;

open FP1, $ARGV[0] ;
open FP2, $ARGV[1] ;

my $diff = 0 ;
my $diffRead = 0 ;

while ( <FP1> )
{
	my $id1 = $_ ;
	my $id2 = <FP2> ;
	if ( ( split /\s+/, $id1 )[0] ne ( split /\s+/, $id2 )[0] )
	{
		die "Unmatched read id ", ( split /\s+/, $id1 )[0], "  and ", ( split /\s+/, $id2 )[0], "\n" ;
	}

	my $seq1 = <FP1> ;
	my $seq2 = <FP2> ;
	chomp $seq1 ;
	chomp $seq2 ;

	my $len = length( $seq1 ) ;
	my $cnt = 0 ;
	for ( my $i = 0 ; $i < $len ; ++$i )
	{
		++$cnt if ( substr( $seq1, $i, 1 ) ne substr( $seq2, $i, 1 ) ) ;
	}

	$diff += $cnt ;
	++$diffRead if ( $cnt > 0 ) ;

	$seq1= <FP1> ;
	$seq1= <FP1> ;
	$seq2= <FP2> ;
	$seq2= <FP2> ;
}
print "$diffRead reads are different. $diff bases are different.\n" ;
