#!/usr/bin/env perl

use strict ;
use warnings ;

while (<>)
{
	my $line = $_ ;
	if ( substr($line, 0, 1) eq ">" )
	{
		print $line ;
		next ;
	}
	chomp $line ;
	my $rc = reverse $line ;
	$rc =~ tr/ACGTacgt/TGCAtgca/ ;
	print $rc, "\n" ;
}
