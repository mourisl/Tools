#!/bin/perl
# Convert scaffolds file to contig file
# Usage: a.pl xxx.fa> yy.fa
use strict ;
my $n ;
#$n = pop @ARGV ;
my $seq = "" ;
my $id = "" ;
my @cols ;
my $i ;
while (<>)
{
	chomp ;
	if ( /^>/ )
	{
		if ( $seq ne "" )
		{
			my $contig = "" ;
			my $l = length( $seq ) ;
			my $cnt = 0 ;
			my $start = 0 ;
			for ( $i = 0 ; $i < $l ; ++$i )
			{
				my $c = substr( $seq, $i, 1 ) ;
				if ( $c eq 'N' || $c eq 'n' )
				{
					if ( $contig ne "" )
					{
						print $id."_"."$cnt:$start-".($i - 1)."\n$contig\n" ;
						++$cnt ;
					}
					$start = $i + 1 ;
					$contig = "" ;
				}
				else
				{
					$contig .= $c ;
				}
			}
			if ( $contig ne "" )
			{
				print $id."_"."$cnt:$start-".($i - 1)."\n$contig\n" ;
				++$cnt ;
			}
		}
		$id = $_ ;
		$seq = "" ;
	}
	else
	{
		$seq .= $_ ;
	}
}
if ( $seq ne "" )
{
	my $contig = "" ;
	my $l = length( $seq ) ;
	my $cnt = 0 ;
	my $start = 0 ;
	for ( $i = 0 ; $i < $l ; ++$i )
	{
		my $c = substr( $seq, $i, 1 ) ;
		if ( $c eq 'N' || $c eq 'n' )
		{
			if ( $contig ne "" )
			{
				print $id."_"."$cnt:$start-".($i - 1)."\n$contig\n" ;
				++$cnt ;
			}
			$start = $i + 1 ;
			$contig = "" ;
		}
		else
		{
			$contig .= $c ;
		}
	}
	if ( $contig ne "" )
	{
		print $id."_"."$cnt:$start-".($i - 1)."\n$contig\n" ;
		++$cnt ;
	}
}
