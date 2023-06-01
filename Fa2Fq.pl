#!/bin/perl

while (<>)
{
	my $line = $_;
	my $len = 0 ;
	substr( $line, 0, 1, '@' ) ;
	print $line ;
	$line = <> ;
	print $line ;
	chomp $line ;
	$len = length( $line ) ;
	print "+\n" ;
	print "I"x$len, "\n" ;
}
