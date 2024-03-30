#!/usr/bin/env perl

# Count the frequency of the items from stdin
# Kind of like "xxx | sort | uniq -c" though the first column is item, second column is count

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
