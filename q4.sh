#!/bin/bash


calc_int() {

declare -A mapping

val=("M" "CM" "D" "CD" "C" "XC" "L" "XL" "X" "IX" "V" "IV" "I")
map=(1000 900 500 400 100 90 50 40 10 9 5 4 1)

len=`echo $1 | wc -c`
len=`expr $len - 1`	 

str=$1
let v=0
let ans=0

for i in ${val[@]}
do 
mapping+=( ["$i"]=${map[$v]} )
v=`expr $v + 1`
done

for ((i=0 ; i<len ; i++))
do
	if [ `expr $i + 1` -lt $len ]
	then
		key=${str:$i:2}

		if [ "${mapping[$key]}" != "" ]
		then
			ans=`expr $ans + ${mapping[$key]}`				
			#echo $key
			i=`expr $i + 1`		
		else
		key=${str:$i:1}
		#echo $key
		ans=`expr $ans + ${mapping[$key]}`
		
		fi
	else
		key=${str:$i:1}
		#echo $key
		ans=`expr $ans + ${mapping[$key]}`
	fi

done

echo $ans;

}




calc_roman() {
arg=$1
val=(1000 900 500 400 100 90 50 40 10 9 5 4 1)
map=("M" "CM" "D" "CD" "C" "XC" "L" "XL" "X" "IX" "V" "IV" "I")
i=0;
for n in ${val[@]}
do
let num=$n
#echo $num
	while [ $arg -ge $num ]
		do
			
			if [ `expr $arg - $num` -ge 0 ]
			then
				#echo `expr $arg - $num`
				#echo $num
				printf "%s" "${map[i]}"
				arg=`expr $arg - $num`
			fi
		done
i=`expr $i + 1`

done


}
#echo $#
if [[ "$#" -le 0 || "$#" -ge 3 ]]
then 
	echo "Invalid Inputs! Try Again"
	exit

fi
if [[ "$#" -eq 1 ]]
then 
	if [[ "$1" -lt 4000 ]]
	then
	calc_roman $1
	else
	echo "Numbers Above 3999 cant be represented in Roman"
	fi

fi



if [[ "$#" -eq 2 ]]
then 
arg1=$1
arg2=$2

#----------both int ---------
#2> /dev/null  : i used to filter out error hence no error will be printed
	if [ $arg1 -eq $arg1 ] 2> /dev/null && [ $arg2 -eq $arg2 ] 2> /dev/null 
	then
		arg=`expr $arg1 + $arg2`
		if [[ "$1" -lt 4000 ]]
		then
		calc_roman $arg
		else
		echo "Numbers Above 3999 cant be represented in Roman"
		fi
		#calc_roman $arg
		
	else
#-------- both roman ------------
		#echo "calc_int"
		let num1=$(calc_int $arg1)
		let num2=$(calc_int $arg2)
		echo `expr $num1 + $num2`	
	fi


fi


