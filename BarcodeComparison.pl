#!/bin/perl

#A00519:46:HGCTLDMXX:2:1118:1208:12414   1187    chr1    10046   0       49M     =       10177   174     CCCTAACCCTAACCCTAACCCTAACCCTAACCCTAACCCTAACCCTAAC FFFFFFFFFFFFFFFFF:FFFFFFFFFFFFFFFFFFFF,FF:FF:,F,F       NM:i:0  MD:Z:49 MC:Z:7S43M      AS:i:49 XS:i:49 CR:Z:TCAAGACAGGTACTCT   CY:Z:FFFFFFF:FFF:FFFF     CB:Z:TCAAGACAGGTACTCT-1 BC:Z:CATTACAC   QT:Z::FFF:FF:   GP:i:10045      MP:i:10219      MQ:i:0  RG:Z:BMMC_PBMC:MissingLibrary:1:HGCTLDMXX:2

my $match = 0 ;
my $total = 0 ;
while (<STDIN>)
{
	chomp ;
	my $raw ;
	my $cor ;

	if (/CR:Z:(.*?)\t/)
	{
		$raw = $1 ;
	}
	else
	{
		continue ;
	}

	++$total ;
	if (/CB:Z:(.*?)-1/)
	{
		$cor = $1 ;
		if ($cor eq $raw)
		{
			++$match ;
		}
	}
}
print( $match, " ", $total, "\n" ) ;
