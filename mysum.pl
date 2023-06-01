#!/bin/perl

use strict ;
use warnings ;

# usage: a.pl < nums 

my $sum = 0 ;
my $cnt = 0 ;
while ( <STDIN> )
{
	$sum += $_ ;
	++$cnt ;
}
print $sum, " ", $sum / $cnt, "\n" ;
