#!/usr/bin/env perl

# Count the frequency of the items

use strict ;
use warnings ;

my %count ;
while (<STDIN>)
{
  chomp ;
  ++$count{$_} ;
}
foreach my $key (keys %count)
{
  print($key."\t".$count{$key}."\n") ;
}
