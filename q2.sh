#!/bin/bash

if [ $# -ne 2 ]
then 
	echo "Invalid Inputs"
	exit
fi


input=$1
output=$2

printf "" | cat > $output

data=`cat $input | awk '{print tolower($0)}'`

#echo $data  

#echo $data | awk -F " " '/ing$/ {print $0}'

#echo $input $output

for word in $data
do 
#echo $word
echo "$word" | grep ing$ | cat >> $output

done
