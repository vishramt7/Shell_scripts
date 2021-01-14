#!/bin/bash
#This script will ask for 1.Folder containing one set of files 2.initial and 3.final temperature of the range needed.

incre=1;
out=K7X_Tf_u;

#echo "First temperature value";
a=$1;

#echo "End temperature value";
b=$2;

for j in {0..24..1}
do
        for ((i=$a;i<=$b;i+=$incre))
        do
        cd ${out}_${i}_${j};
	echo 9 | g_energy -f *.edr -o energy.xvg	
	egrep -v "@|#|&" energy.xvg | awk '{print $2}' > energy.txt
	B=$(awk '{if ($1<=-50) print NR}' energy.txt | head -n1 );

	echo -e "[ frames ]\n${B}" > folded.ndx
	echo 1 | trjconv -f Output.xtc -s ../../../2K7X_dimer_CA_cent.pdb -fr folded.ndx -o ${out}_${i}_${j}.pdb

        cd ..
        echo $i;
        done
        wait
done
