# Remove redundant transcripts with the same intron chain from the GTF file
#!/bin/perl

use strict ;

#chr1	HAVANA	transcript	11869	14409	.	+	.	gene_id "ENSG00000223972.4"; transcript_id "ENST00000456328.2"; gene_type "pseudogene"; gene_status "KNOWN"; gene_name "DDX11L1"; transcript_type "processed_transcript"; transcript_status "KNOWN"; transcript_name "DDX11L1-002"; level 2; tag "basic"; havana_gene "OTTHUMG00000000961.2"; havana_transcript "OTTHUMT00000362751.1";
my @cols ;
my $prevLine = 0 ;
my $line ;
my %transcripts ;
my $key ;
my $val ;
my $i ;
my $chrom ;
my $cnt = 0 ;
my @ends ;
my $exonCnt = 0 ;

my $keepSingleExonTxpt = 1 ;

die "a.pl *.gtf [-M] > out\n" if ( @ARGV eq 0 ) ;
open FP1, $ARGV[0] ;

for ( $i = 0 ; $i < @ARGV ; ++$i )
{
	if ( $ARGV[$i] =~ /-M/ )
	{
		$keepSingleExonTxpt = 0 ;
	}
}
while (<FP1>)
{
	my $beginNew = 0 ;
	@cols = split ;
	$line = $_ ;
	if ( $prevLine ne 0 )
	{
		my $tid = 0 ;
		my $prevTid = 1 ;
		
		if ( $line =~ /transcript_id \"(.+?)\"/) 
		{
			$tid = $1 ;
			#print $tid, "\n" ;
		}
		if ( $prevLine =~ /transcript_id \"(.+?)\"/) 
		{
			$prevTid = $1 ;
		}

		if ( $tid ne $prevTid )
		{
			$beginNew = 1 ;
		}

	}

	if ( $beginNew == 1 && $exonCnt > 0 )
	{
		my @prevCols ;
		@prevCols = split /\s/, $prevLine ;
		$key = $prevCols[6] ;
		#print $key, "\n" ;
		for ( $i = 1 ; $i + 1 < @ends ; $i += 2 )
		{
			$key = $key.$ends[$i]." ".$ends[$i+1]."." ;
		}

		if ( defined $ends[0] )
		{
			if ( length( $key ) eq 1 )
			{
				$key = $key.$ends[0]." ".$ends[1] ;
			}
			if ( $exonCnt > 1 || $keepSingleExonTxpt == 1 )
			{
				$transcripts{$key} = $val ;
			}
		}
		#$val = $_ ;
		$val = "" ;	
		undef( @ends ) ;
		$exonCnt = 0 ;
	}
	
	if ( $cols[2] eq "exon" )
	{
		#if ( $cols[4] eq 160061398 )
		#{
		#	print "hi\n" ;
		#}
		if ( ( defined $ends[0] ) && $cols[4] < $ends[0] )
		{
			my @tmpQ = @ends ;
			undef( @ends ) ;
			push @ends, $cols[3], $cols[4] ;
			push @ends, @tmpQ ;
		}
		else
		{
			push @ends, $cols[3], $cols[4] ;
		}
		++$exonCnt ;
		$val = $val.$_ ;
	}

	$prevLine = $line ;
}

if ( $exonCnt > 0 )
{
	my @prevCols ;
	@prevCols = split /\s/, $prevLine ;
	$key = $prevCols[6] ;
#print $key, "\n" ;
	for ( $i = 1 ; $i + 1 < @ends ; $i += 2 )
	{
		$key = $key.$ends[$i]." ".$ends[$i+1]."." ;
	}

	if ( defined $ends[0] )
	{
		if ( length( $key ) eq 1 )
		{
			$key = $key.$ends[0]." ".$ends[1] ;
		}
		if ( $exonCnt > 1 || $keepSingleExonTxpt == 1 )
		{
			$transcripts{$key} = $val ;
		}
	}
#$val = $_ ;
	$val = "" ;	
	undef( @ends ) ;
	$exonCnt = 0 ;
}

while (($key, $val) = each %transcripts)
{
	print $val ;
}
