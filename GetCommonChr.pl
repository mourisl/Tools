#!/bin/perl
#Get the common chr from a gtf file
#usage: perl a.pl *.gtf
my @line ;
my $tmp ;
while (<>)
{
	$tmp = $_ ;
	@line = split ;
	next if ( $line[0] =~ /_/ ) ;
	print $_ ;
}
