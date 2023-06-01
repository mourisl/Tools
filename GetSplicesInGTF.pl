#!/bin/perl

my @prevLine, @line ;

while (<>)
{
	@line = split ;
	if ( $line[2] =~ /exon/ && $prevLine[2] =~ /exon/ )
	{
		if ( $prevLine[4] < $line[3] )
		{
			print "$prevLine[4]\t$line[3]\n" ;
		}
		else
		{
			print "$line[4]\t$prevLine[3]\n" ;
		}
	}

	@prevLine = @line ;
}
