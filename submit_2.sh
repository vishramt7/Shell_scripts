#!/bin/bash
#This script will ask for 1.Folder containing one set of files 2.initial and 3.final temperature of the range needed.

incre=1;
out=SUMO1;

#echo "Give the folder containing basic set of files";
infile=$1;

#echo "First temperature value";
a=$2;

#echo "End temperature value";
b=$3;

for j in {1..4..1}
do
	for ((i=$a;i<=$b;i+=$incre)) 
	do 
	cd ${infile};
	sed -i -e "s/\(ref_t = \).*/\1$i/" -e "s/\(gen_temp = \).*/\1$i/" *.mdp
	cd ..
	cp -r ${infile} ${out}_l${j}_${i};	

        cd ${out}_l${j}_${i};
        rm *.gro
        cp ../frame${j}.gro ../${out}_l${j}_${i};
        qsub SGE_script.sh
        cd ..
	echo $i;
	done 
	wait
done
