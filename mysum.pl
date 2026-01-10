#!/bin/perl

use strict ;
use warnings ;

# usage: a.pl < nums (can be multicolumn)

my @sum ;
my $cnt = 0 ;
my $i ;
while ( <STDIN> )
{
  chomp ;
  my @nums = split ; 
  if ($cnt == 0)
  {
    for ($i = 0 ; $i < scalar(@nums) ; ++$i)
    {
      push @sum, 0 ;
    }
  }

  for ($i = 0 ; $i < scalar(@nums) ; ++$i)
  {
  	$sum[$i] += $nums[$i] ;
  }
	++$cnt ;
}

for ($i = 0 ; $i < scalar(@sum) ; ++$i)
{
  print $sum[$i], " ", $sum[$i] / $cnt, "\n" ;
}
