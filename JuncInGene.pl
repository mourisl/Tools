#!/bin/perl

#use warnings ; 

my $argc = @ARGV ;
my $gtfFile, $spliceFile ;
my %spliceGeneType, %spliceGeneId, %spliceTranscriptId ;
my @line, @prevLine ;
my $eid, $prevEid ; # exon number
die "Format: xx.pl gtf_file splice_file\n" if $argc != 2 ;

$spliceFile = pop @ARGV ;
while (<>)
{
	@line = split ;
	next if ( !( $line[2] =~ /exon/ ) ) ;
	if ( !defined $prevLine[0] )
	{
		@prevLine = @line ;
		next ;
	}
	
	$eid = 0 ;
	$prevEid = 0 ;
	if ( $line[13] =~ /\"(\w+)\"/)
	{
		$eid = $1 ;
	}
	if ( $prevLine[13] =~ /\"(\w+)\"/ )
	{
		$prevEid = $1 ; 
	}
	#print "$prevEid, $eid\n@prevLine\n@line\n" ;
	#if ( $line[4] == 17160986 )
	#{
	#	die "@prevLine\n@line\n" ;
	#}
	$line[15] =~ s/\"// ;
	$line[15] =~ s/;// ;

	if ( ( $line[11] eq $prevLine[11] ) ) 
	{
		if ( $prevLine[4] < $line[3] )
		{
			$spliceGeneType{ "$line[0]\t$prevLine[4]\t$line[3]" } = $line[1] ; 	
			$spliceGeneId{ "$line[0]\t$prevLine[4]\t$line[3]" } = $line[15] ; 	
			$spliceTranscriptId{ "$line[0]\t$prevLine[4]\t$line[3]" } = $line[15] ; 	
		}
		else
		{
			$spliceGeneType{ "$line[0]\t$line[4]\t$prevLine[3]" } = $line[1] ; 	
			$spliceGeneId{ "$line[0]\t$line[4]\t$prevLine[3]" } = $line[15] ; 	
			$spliceTranscriptId{ "$line[0]\t$line[4]\t$prevLine[3]" } = $line[15] ; 	
		}
	}
	@prevLine = @line ;
}

push @ARGV, $spliceFile ;
while (<>)
{
	my $s = $_ ;
	my $key = "$line[0]\t$line[1]\t$line[2]" ; 
	@line = split ;
	if ( !( defined $spliceGeneType{$key} ) ) 
	{
		print "N ", $s,  ;
	}
	else
	{
		print "Y ", $s ;
	}
}
