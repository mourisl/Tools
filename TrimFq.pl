#!/bin/perl

use strict ;
use warnings ;

die "usage: a.pl bp < xxx.fq > new.fq\n" if ( @ARGV == 0 ) ;

my $len = $ARGV[0] ;
while ( <STDIN> )
{
	print $_ ;
	my $seq = <STDIN> ;
	chomp $seq ;
	print substr( $seq, 0, $len ), "\n" ; 
	my $sep = <STDIN> ;
	print $sep ;
	my $qual= <STDIN> ;
	chomp $qual ; 
	print substr( $qual, 0, $len ), "\n" ; 
}
