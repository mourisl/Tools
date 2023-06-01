#!/bin/perl
# usage: a.pl [minLength] [sum] < xxx.fa
my $seq = "" ;
my $id ;
my @length ;
while (<STDIN>)
{
	chomp ;
	if ( /^>/ )
	{
		if ( $seq ne "" )
		{
			push @length, length( $seq ) ;
		}
		$id = $_ ;
		$seq = "" ;
	}
	else
	{
		$seq .= $_ ;
	}
}
push @length, length( $seq ) ;
my $i ;
my $sum = 0 ;
my $minLen = -1 ;
my $contgiCnt = 0 ;

if ( defined $ARGV[0] )
{
	$minLen = $ARGV[0] ;
}
for ( $i = 0 ; $i < scalar( @length ) ; ++$i )
{
	next if ( $length[$i] < $minLen ) ;
	$sum += $length[$i] ;
	++$contigCnt ;
}

my $psum = 0 ;
if ( defined $ARGV[1] )
{
	$sum = $ARGV[1] ;
}
my $tmp ;
my $k = 0 ;
print "Total number of contigs longer than $minLen: $contigCnt\n" ;
print "Total length: $sum\n" ;
foreach $i (sort {$b<=>$a} @length )
{
	last if ( $i < $minLen ) ;
	$psum += $i ;
	$tmp = $i ;
	while ( $psum >= $sum * $k / 100 ) 
	{
		print "N$k: $tmp\n" ;
		$k += 10 ;
	}
}
#print "$sum\t$tmp\n" ;
