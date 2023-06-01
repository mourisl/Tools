#!/bin/perl
use strict ;

my $sumMD = 0 ;
my $sum = 0 ;
my $sumBase = 0 ;
my @cols = 0 ;
my $i ;

while(<>)
{
	@cols = split ;
	next if ( ( $cols[1] & 0x900 ) != 0 ) ;
	if ( /MD:Z:(.+?)\s/ )
	{
		#print $1, "\n" ;
		$sumBase += length( $cols[9] ) ;
		my $sum1 = 0 ;
		@cols = split /[A-Z\^]+/, $1 ;
		#print @cols, "\n" ;
		
		for ( $i = 0 ; $i < scalar(@cols) ; ++$i )
		{
			#print $cols[$i], " " ;
			$sum1 += $cols[$i] ;
		}
		$sumMD += $sum1 ;
		
		++$sum ;
	}
}
print $sum, " ",$sumMD, " ", $sumMD / $sumBase * 100.0, "\n"
