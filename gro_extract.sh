#!usr/bin/bash
# This script will extact the first strcutre from .xtc file
# The input is the Q range , .Q file and .xtc file

min=$1;
max=$2;

for i in {1..100..1}
do 
	frame=$(awk '{if ($1>='${min}' && $1<='${max}') {print NR ; exit}}' frames_${i}.xtc_pairs_top.txt.CA.Q )
	if [[ ! -z ${frame} ]]
	then
		echo [ frames ] > temp_${i}.ndx
		echo ${frame} >> temp_${i}.ndx
		echo 1 | trjconv -f frames_${i}.xtc -s Output.tpr -fr temp_${i}.ndx -o gro_${i}.gro
		rm temp_${i}.ndx
	else	
		echo "frame not present for ${i}"
	fi
done
