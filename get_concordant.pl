use strict;

my $L = 10000;

while (<>) {
   /^(\S+)\t(\S+)\t(\S+)\t\S+\t\S+\t\S+\t(\S+)\t\S+\t(\S+)\t\S+\t/ or die "died. $_";
   my ($readid,$flag,$chrom,$mate_chrom,$isize) = ($1,$2,$3,$4,$5);

   next if (($chrom eq "*") || ($flag & 0x40) == ($flag & 0x80));

   my $idx  = ($flag & 0x40) ? 1 : 2;
   my $ori1 = ($flag & 0x10) ? "R" : "F";
   my $ori2 = ($flag & 0x20) ? "R" : "F";

   next if ($ori1 eq $ori2);
   
   if ($idx==1) {
     if (($ori1 eq "F") && (0<=$isize && $isize<=$L)) { print $readid, "\n"; next; }
     if (($ori1 eq "R") && (-$L<=$isize && $isize<=0)) { print $readid, "\n"; next; }
   } elsif ($idx==2) {
     if (($ori1 eq "F") && (0<=$isize && $isize<=$L)) { print $readid, "\n"; next; }
     if (($ori1 eq "R") && (-$L<=$isize && $isize<=0)) { print $readid, "\n"; next; }
   } else {
     die "unrecognized index. $idx\n";
  }
}


