#!/bin/sh
for i in `ls *.eps`
do
	j=`basename $i .eps`
	#echo $j
	convert -geometry 800x800 -density 800 $i -flatten $j.png
done
