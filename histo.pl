#!/usr/bin/perl
use strict;

($#ARGV==2) or die "Usage: $0 min max nbins\n";

my $m = shift;
my $M = shift;
my $nBins = shift;

my $count = 0;

my %Bins;
for (my $i=0; $i<=$nBins; $i++) {
   $Bins{"$i"} = 0;
}

while (<>) {
   chomp $_;

   if ($_<$m) {
     $Bins{0}++;
#    print "<<<$_ 0>>>\n";
   } elsif ($_>$M) {
     $Bins{$nBins}++;
#    print "<<<$_ $nBins>>>\n";
   } else { 
     my $i = int(($_-$m)*$nBins/($M-$m));
#    print "<<<$_ $i>>>\n";
     $Bins{$i}++;
   }
   $count++;
}

for (my $i=0; $i<=$nBins; $i++) {
   print "$i " . ($m+($i*(($M-$m)/$nBins)));
   print " ", $Bins{$i}, " ", (100*$Bins{$i}/$count), "\n";
}
