#!/bin/perl

my $seq = "" ;
while (<>)
{
	if ( /^>/ )
	{
		print $seq, "\n" if ( $seq ne "" ) ;
		print $_ ;
		$seq = "" ;
		next ;
	}
	chomp ;
	$seq .= $_ ;
}
print $seq, "\n" if ( $seq ne "" ) ;



