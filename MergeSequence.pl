#!/bin/perl

while (<>)
{
	chomp ; 
	next if ( /^>/ ) ;
	print $_ ;
}
