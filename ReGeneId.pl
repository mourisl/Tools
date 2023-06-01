#!/bin/perl

use strict ;
my $line ;
my $prevLine = -1 ;
my @cols ;
my @prevCols ;
my $id = 0 ;

while (<>)
{
	$line = $_ ;
	@cols = split ; 
	if ( $prevLine eq -1 ) 
	{
		my $output = $line ;
		$output =~ s/gene_id \".*?\"/gene_id \"$cols[0]_$id\"/g ;
		$output =~ s/gene_name \".*?\"/gene_name \"$cols[0]_$id\"/g ;
		print $output ;
		$prevLine = $line ;
		next ;
	}

	@prevCols = split /\s/, $prevLine ;
	my $tid ;
	my $prevTid ;

	my $gid ;
	my $prevGid ;

	if ( $prevLine =~ /transcript_id \"(.+?)\"/ )
	{
		$prevTid = $1 ;
	}
	if ( $line =~ /transcript_id \"(.+?)\"/ )
	{
		$tid = $1 ;
	}

	if ( $prevLine =~ /gene_id \"(.+?)\"/ )
	{
		$prevGid = $1 ;
	}
	if ( $line =~ /gene_id \"(.+?)\"/ )
	{
		$gid = $1 ;
	}

	#if ( $prevTid ne $tid && ( $cols[3] > $prevCols[3] + 10000 || $cols[6] != $prevCols[6] || ) )
	if ( $prevGid ne $gid || $cols[6] ne $prevCols[6] )
	{
		++$id ;
	}
	my $output = $line ;
	$output =~ s/gene_id \".*?\"/gene_id \"$cols[0]_$id\"/g ;
	$output =~ s/gene_name \".*?\"/gene_name \"$cols[0]_$id\"/g ;
	print $output ;


	$prevLine = $line ;
}
