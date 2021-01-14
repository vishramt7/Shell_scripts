#!/usr/bin/bash
# The first argument is folder name, second and third are the CVs


array=("$@");
array_len=${#array[@]} # This helps to get the array length

plumed sum_hills --hills ${array[0]}/HILLS --outfile ${array[0]}/fes.dat # This gives the fes.dat file
if [ "$array_len" -gt 2 ]
then
	for (( i=1; i<$array_len; i++))
	do 
		echo ${array[$i]};
		plumed sum_hills --hills ${array[0]}/HILLS --idw ${array[$i]} --kt 2.5 --mintozero --outfile ${array[0]}/fes_${array[$i]}.dat
	done
else
	plumed sum_hills --hills ${array[0]}/HILLS --mintozero --outfile ${array[0]}/fes_${array[1]}.dat
fi
