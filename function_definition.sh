#!c/WINDOWS/system32/bash

func1 () {
	echo "$# This is where func1 is defined"
	sum=0
	val=1
	while [ $val -le $# ]
	do
		sum=$[ $sum + ${!val} ]
		val=$[ $val + 1 ]
	done
	echo $sum
}

#count=1
#while [ $count -le 5 ]
#do
result=$(func1 5 10 15)
echo $result

#	echo $count
#	count=$[ $count + 1 ]
#done


