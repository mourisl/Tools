#!/usr/bin/env python3

import sys
from pyliftover import LiftOver

if ( len( sys.argv ) <=1 ):
	print( "usage: a.py chr pos [chain] > liftover.vcf" )
	sys.exit()

lo = None
if ( len( sys.argv ) >= 4 ):
	lo = LiftOver( sys.argv[3] ) 
else:
	lo = LiftOver( "/homes/lsong/data/LiftOver/hg19ToHg38.over.chain.gz" ) 
newCoord = lo.convert_coordinate( sys.argv[1], int( sys.argv[2] ) - 1 ) # vcf is 1-based coordinate 
if ( newCoord == None or len( newCoord ) == 0 ):
	print( "Invalid" )
	sys.exit()
print( newCoord[0][0] + "\t" + str( newCoord[0][1] + 1 ) )

