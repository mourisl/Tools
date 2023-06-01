# Append another column indicating the gene name from tmap file
#!/bin/perl

#WASH7P	ENST00000438504.2	j	chr1.0	chr1.0	100	0.000000	0.000000	0.000000	0.000000	2198	chr1.0	1785

die "Format: a.pl xxx.tmap grader.intron\n" if ( @ARGV == 0 ) ;
open fp1, $ARGV[0] ;
open fp2, $ARGV[1] ;

my %geneId ; 
my $line ;
my @cols ;

while ( <fp1> )
{
	@cols = split ;
	$geneId{ $cols[4] } = $cols[0] ;
}

while ( <fp2> )
{
	chomp ;
	$line = $_ ;
	@cols = split ;
	if ( defined $geneId{ $cols[4] } )
	{
		print $line, "\t", $geneId{ $cols[4] }, "\n" ;  
	}
	else
	{
		print $line, "\t-\n" ;  
	}
}

close fp1 ;
close fp2 ;
