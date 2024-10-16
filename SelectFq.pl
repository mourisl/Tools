#!/usr/bin/env perl

# Select sequences with specified IDs from a FASTQ file.

use strict ;
use warnings ;

die "Usage: a.pl idlist < input.fq > selected.fq\n" if (@ARGV == 0) ;

open FP, $ARGV[0] ;
my %selectedId ;
while (<FP>)
{
  chomp ;
  $selectedId{$_} = 1 ;
}
close FP ;

my $header = "" ;
my $seq = "";
my $separator = "" ;
my $qual = "" ;

while (<STDIN>)
{
	chomp ;
	$header = $_ ;
	$seq = <STDIN> ;
	$separator = <STDIN> ;
	$qual = <STDIN> ;

	chomp $seq ;
	chomp $separator ;
	chomp $qual ;

	if (defined $selectedId{(split /\s/, substr($header, 1))[0]} )
	{
		print "$header\n$seq\n$separator\n$qual\n" ;
	}
}
