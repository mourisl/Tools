#!/usr/bin/env perl

use strict ;
use warnings ;

while (<>)
{
	my $line = $_ ;
	print $line ;
	
	$line = <> ;
	chomp $line ;
	my $rc = reverse $line ;
	$rc =~ tr/ACGTacgt/TGCAtgca/ ;
	print $rc, "\n" ;

	$line = <>;
	print $line ;

	$line = <> ;
	chomp $line ;
	$rc = reverse $line ;
	print $rc, "\n" ;
}
