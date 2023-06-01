#!/bin/perl

use strict ;

my $usage = "a.pl ref.fa num_of_reads [-r]" ;

die "$usage\n" if ( @ARGV == 0 ) ;

open FP1, $ARGV[0] ;
my $num = $ARGV[1] ;
my $random = 0 ;

$random = 1 if ( $ARGV[2] eq "-r" ) ;

my $ref = "" ;
while ( <FP1> )
{
	next if ( /^>/ ) ;

	chomp ;
	$ref .= $_ ;
}

my $i ;
srand( 17 ) ;
for ( $i = 0 ; $i < $num ; ++$i )
{
	print ">read_$i\n" ;
	if ( $random eq 0 )
	{
		print substr( $ref, 1000000, 100 ), "\n" ;
	}
	else
	{
		my $pos = int(rand( length( $ref ) - 101 ) ) ; 
		print substr( $ref, $pos, 100 ), "\n" ;
	}
}
