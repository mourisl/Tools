#!/usr/bin/env perl

use strict ;
use warnings ;

die "usage: a.pl htseq_count.txt gene_exon_length [TPM] > output.txt\n" if (@ARGV == 0);

my %geneExonLen ;
open FP, $ARGV[1] ;
while (<FP>)
{
	chomp ;
	my @cols = split ;
	$geneExonLen{$cols[0]} = $cols[1] ;
}
close FP ;

my %fpk ;
my $sum = 0 ;
my $fpkSum = 0;
open FP, $ARGV[0] ;
while (<FP>)
{
	chomp ;
	my @cols = split ;
	next if (!defined $geneExonLen{$cols[0]}) ;
	$fpk{ $cols[0] } = $cols[1] / $geneExonLen{$cols[0]} * 1000 ;
	$fpkSum += $cols[1] / $geneExonLen{$cols[0]} * 1000 ;
	$sum += $cols[1] ;
}
close FP ;


if (@ARGV >= 3 ) 
{
	# TPM
	foreach my $key (keys %fpk)
	{
		print $key, "\t", $fpk{$key}/ $fpkSum * 1000000, "\n" ;
	}
}
else
{
	# FPKM
	foreach my $key (keys %fpk)
	{
		print $key, "\t", $fpk{$key} / $sum * 1000000, "\n" ;
	}
}
