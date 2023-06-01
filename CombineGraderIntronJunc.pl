# Put the splice information form the splice file to the grader.intron
#!/bin/perl

die "Format: a.pl *.splice grader.introns\n" if ( @ARGV == 0 ) ;
my $file = pop @ARGV ;
my %splices ;
my @cols ;
my $line ;
while (<>)
{
	$line = $_ ;
	@cols = split ;
	$splices{ $cols[0]." ".$cols[1]." ".$cols[2] } = $line ;	
	#print $cols[0]." ".$cols[1]." ".$cols[2]."\n" ;
}

push @ARGV, $file ;
while (<>)
{
	chomp ;
	print $_ ;
	@cols = split ;
	my $tmp = $cols[1]." ".$cols[2]." ".$cols[3] ;
	if ( defined $splices{$tmp} )
	{
		@cols = split /\s/, $splices{$tmp} ;
		print "\t$cols[5]\t$cols[6]\t$cols[7]\t$cols[8]\n" ;
	}
	else
	{
		print "\t-1\t-1\t-1\t-1\n" ;
	}
}
