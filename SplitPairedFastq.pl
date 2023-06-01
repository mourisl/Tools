#The paired-end reads in fastq file generated from SRA file is concatenated.
#This program is used to split the paired reads and put them in two files.
#NOTE: the length of the reads is hard-coded
#!/bin/perl
my @lines ;
my $header ;

if ( @ARGV == 0 )
{
	die "Format: a.pl prefix_fastq read_length\n" ;
}

#my $fp1, $fp2 ;
open fp1, ">$ARGV[0].rd1.fastq" ;
open fp2, ">$ARGV[0].rd2.fastq" ;

while ( $line[1] = <STDIN> )
{
	$line[2] = <STDIN> ;
	$line[3] = <STDIN> ;
	$line[4] = <STDIN> ;
	
	$header = $line[1] ;
	$header =~ s/ length=150/\/0/ ;
	
	print fp1 $header.substr( $line[2], 0, $ARGV[1] )."\n+\n".substr( $line[4], 0, $ARGV[1] )."\n" ;
	$header = $line[1] ;
	$header =~ s/ length=150/\/1/ ;
	print fp2 $header.substr( $line[2], $ARGV[1], $ARGV[1] )."\n+\n".substr( $line[4], $ARGV[1], $ARGV[1] )."\n" ;
}
