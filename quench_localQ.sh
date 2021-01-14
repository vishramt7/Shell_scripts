#!/bin/bash
#This script will ask for 1.Folder containing one set of files 2.initial and 3.final temperature of the range needed.

LA=6;		# This decides the load average. For N cores, keep it N-2
incre=1;	
out=H2Z_DW6_Tf_u;

#echo "Give the folder containing basic set of files";
infile=$1;

#echo "First temperature value";
a=$2;

#echo "End temperature value";
b=$3;

for j in {0..24..1}
do
	for ((i=$a;i<=$b;i+=$incre)) 
	do 
#	cd ${infile};
#	sed -i -e "s/\(ref_t = \).*/\1$i/" -e "s/\(gen_temp = \).*/\1$i/" *.mdp
#	cd ..
	cp -r ${infile} ${out}_${i}_${j};	

        cd ${out}_${i}_${j};
	rm *.gro
       	mv ../frame_u_${i}_${j}.gro ../${out}_${i}_${j};
        sh SGE_script_pd.sh
	sleep 80
	B=$(cat /proc/loadavg | awk '{print $1}');
	C=$(awk -v var1="$B" -v var2="$LA" 'BEGIN {if (var1>=var2) print 0 ; else print 1}');
	        while [ $C -eq 0 ]
	        do
	        sleep 20
	        B=$(cat /proc/loadavg | awk '{print $1}');
	        C=$(awk -v var1="$B" -v var2="$LA" 'BEGIN {if (var1>=var2) print 0 ; else print 1}');
	        done
        cd ..
	echo $i;
	done 
	wait
done
