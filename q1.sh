#!/bin/bash

dir=`ls -lS | grep "^d" | awk -F "[0-9][0-9]:[0-9][0-9] " '{print $NF"?"}' | tr -d '\n' `

newfile=""
IFS='?'
for i in $dir
do
	
	size=`du -sh "$i" | awk -F "\t" '{print $1}' | sed -e 's/K$/KB/' -e 's/M$/MB/' -e 's/G$/GB/' -e 's/[0-9]B$/Bytes/' `
	nname=`echo $i | sed 's/ /_/g'`
	#echo $nname
	newfile="$newfile$nname\t$size\n"
	#echo $newfile
	


done
IFS=' '
#echo -e "$newfile"


echo -e $newfile | awk -F " " '/[^\n]/ {print $1"\t"$2}' | sort -rhk2
