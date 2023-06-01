#!/bin/perl

#usage: a.pl xxx.fa chr_name

open FP1, $ARGV[0] ;
my $pattern = $ARGV[1] ;

my $start = 0 ;
my $seq = "" ;
while ( <FP1> )
{
	if ( /^>$pattern(\s|$)/ )
	{
		$start = 1 ;
		print $_ ;
	}
	elsif ( /^>/ )
	{
		last if ( $start == 1 ) ;
	}
	elsif ( $start == 1 )
	{
		chomp ;
		$seq .= $_ ;
	}
}
print $seq, "\n" ;
close FP1 ;
