#!/usr/bin/env perl

use strict ;
use warnings ;

die "usage: a.pl xxx.sam yyy.sam\n" if (@ARGV == 0);

open FP1, $ARGV[0] ;
open FP2, $ARGV[1] ;


my $diff = 0 ;
my $total = 0 ;
while (1) 
{
	my $line1 = "";
	my @cols1 ;
	my @cols2 ;
	while (<FP1>)
	{
		$line1 = $_ ;
		chomp $line1;
		next if ($line1 =~ /^@/) ;
		@cols1 = split /\t/, $line1 ;
		#print $line1 ;
		#die "\n" ;
		last if (not($cols1[1] & 0x900)) ;
	}
	last if ($line1 eq "") ;

	my $line2 = "";
	while (<FP2>)
	{
		$line2 = $_;
		chomp $line2 ;
		next if ($line2 =~ /^@/) ;
		@cols2 = split /\t/, $line2 ;
		last if (not($cols2[1] & 0x900)) ;
	}

	if (($cols1[1]&0x4) != ($cols2[1]&0x4) || ($cols1[3] ne $cols2[3]))
	{
		#print($line1, "\n", $line2, "\n") ;
		++$diff ;
	}
	++$total ;
	print("Processed $total reads. Diff $diff\n") if ($total % 1000000 == 0) ;
}
print("Different alignment $diff / $total\n") ;
