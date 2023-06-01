#!/bin/perl

my $argc = @ARGV ;
my $gtfFile, $spliceFile ;
my %spliceGeneType, %spliceGeneId ;
my @line ;
die "Format: xx.pl gtf_file splice_file\n" if $argc != 2 ;

$spliceFile = pop @ARGV ;
while (<>)
{
	next if ( !/^chr/ && !/^[1-9XY]/ ) ;
	@line = split ;
	if ( /^[1-9XY]/ )
	{
		$spliceGeneType{ "chr$line[0]\t$line[3]" } = $line[1] ; 	
		$spliceGeneId{ "chr$line[0]\t$line[3]" } = $line[9] ; 	
	
		$spliceGeneType{ "chr$line[0]\t$line[4]" } = $line[1] ; 	
		$spliceGeneId{ "chr$line[0]\t$line[4]" } = $line[9] ; 	
	}
	else
	{
		$spliceGeneType{ "$line[0]\t$line[3]" } = $line[1] ; 	
		$spliceGeneId{ "$line[0]\t$line[3]" } = $line[9] ; 	
	
		$spliceGeneType{ "$line[0]\t$line[4]" } = $line[1] ; 	
		$spliceGeneId{ "$line[0]\t$line[4]" } = $line[9] ; 	
	}
}

push @ARGV, $spliceFile ;
while (<>)
{
	@line = split ;
	for ( my $i = 1 ; $i <= 2 ; ++$i )
	{
		next if ( !( defined $spliceGeneType{ "$line[0]\t$line[$i]" } ) ) ;
		print $spliceGeneId{ "$line[0]\t$line[$i]" }, " ", $spliceGeneType{ "$line[0]\t$line[$i]" }, "\n" ;
	}
}
