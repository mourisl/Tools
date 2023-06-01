# Sort GTF so components with the same tid come together.
#!/bin/perl

my %tid ;
my $buffer ;
my $key, $val, $i ;
while (<>)
{
	$buffer = $_ ;
	if ( /transcript_id \"(.+?)\"/ )
	{
		#print $1, "\n" ;
		$tid{ $1 } .= $buffer ;
	}
}

foreach $val (values %tid)
{
	print $val ;
}

