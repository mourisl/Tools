#!/bin/perl

while (<>)
{
	my $line = $_;
	substr( $line, 0, 1, '>' ) ;
	print $line ;
	$line = <> ;
	print $line ;
	$line = <> ;
	$line = <> ;
}
