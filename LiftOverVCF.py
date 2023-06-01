#!/usr/bin/env python3

import sys
from pyliftover import LiftOver

if ( len( sys.argv ) <=1 ):
	print( "usage: a.py xxx.vcf [chain_file]> liftover.vcf" )
	sys.exit()

lo = None
if ( len( sys.argv ) >= 3 ):
	lo = LiftOver( sys.argv[2] ) 
else:
	lo = LiftOver( "/homes/lsong/data/LiftOver/hg19ToHg38.over.chain.gz" ) 

with open( sys.argv[1] ) as fp:
	for line in fp:
		line = line.rstrip()
		if ( line[0] == '#' ):
			print( line )
			continue ;

		cols = line.split( '\t' )
		if ( cols[0][0] != 'c' ):
			cols[0] = "chr"+cols[0]
		newCoord = lo.convert_coordinate( cols[0], int( cols[1] ) - 1 ) # vcf is 1-based coordinate 
		if ( newCoord == None or len( newCoord ) == 0 ):
			continue 
		cols[0] = newCoord[0][0]
		cols[1] = str( newCoord[0][1] + 1 ) 
		print( "\t".join( cols ) )

