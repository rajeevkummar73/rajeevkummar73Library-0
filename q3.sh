#!/bin/bash

#Validating if Number of Inputs are correct or not
if [ $# -ne 1 ]
then
	echo One Input Expected
	exit
fi

#Creating empty hash map



#Getting All commands that are available in /bin
mcmd1=`compgen -b | sort`
mcmd=`find /bin/ -type f -printf '%f\n' | sort`

mcmd2=""
mcmd2+=$mcmd1
mcmd2+=$mcmd
mcmd=`echo $mcmd2 | sed -e 's/ /\n/g' | sort | uniq`


#for i in $mcmd
#do
#	echo $i
#done
#echo $mcmd

#checking whether mapping file exists or not
if [ -f "cmd_mapping" ]
then
	#Mapping file exists, Hence loading it to the mapping variable
	declare -A mapping
	source -- "cmd_mapping"
	#echo mapping file found using the cached file

else
	declare -A mapping
	#For every command sorting it and making it a Key and original command as value.
	# command : grep
	#sorting grep : egpr
	#mapping["egpr"]="grep"


	for i in $mcmd
	do

	key=`echo "$i" | grep -o . | sort | tr -d "\n"`

	if [ "${mapping[$key]}" != "" ]
	then 
		#echo match found!
		txt=${mapping[$key]}
		txt+='\t'"$i"
		mapping[$key]="$txt"
		
	else

		mapping+=( [$key]="$i" )

	fi


	done
	
	#info :In bash, declare -p can be used to dump the definition of a variable as shell code ready to be interpreted
	
 
	declare -p mapping > "cmd_mapping"
	#echo mapping file generated "cmd_mapping"
fi


#echo mapping completed!

#for key in ${!mapping[@]}; do
#    echo ${key} ${mapping[${key}]}
#done


skey=`echo "$1" | grep -o . | sort | tr -d "\n"`
if [ "${mapping[$skey]}" != "" ]
then
	echo -e "YES\t${mapping[$skey]}"
else
	echo -e "NO\t$1"

fi


