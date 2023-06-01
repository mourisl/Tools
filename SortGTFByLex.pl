# Sort GTF by chrom's lex id
#!/bin/perl

my %chrom ;
my %chromId ;
my @line ;
my $buffer ;
my $key, $val, $i ;
my @sortChromId ;
while (<>)
{
	$buffer = $_ ;
	@line = split ;
	$chrom{ $line[0] } .= $buffer ;
	$chromId{ $line[0] } = 1 ;
}
while ( ($key, $val ) = each %chromId ) 
{
	push @sortChromId, $key ;
}

@sortChromId = sort @sortChromId ;

foreach ( @sortChromId )
{
	print $chrom{$_} ;
}
