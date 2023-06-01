#!/bin/perl
my $txpt ;
my @line ;
my $cnt = 0 ;
while (<>)
{
	@line = split ;
	if ( !( $line[2] =~ /exon/ ) )
	{
		print $txpt if ( $cnt > 2 ) ;
		$cnt = 0 ;
		$txpt = $_ ;
	}
	else
	{
		++$cnt ;
		$txpt = $txpt.$_ ;
	}
}
