#!/bin/bash
#This script will ask for 1.Folder containing one set of files 2.initial and 3.final temperature of the range needed.
#This script will generate folders at the increment of five degrees.

#nsteps=$1
#ref_temp_gen_temp=$2

LA=2; 		# This decides the load average. For N cores, keep it N-2
incre=10;
out=WH2Z_Cter_f;
	
#echo "Give the folder containing basic set of files";
#read infile;
infile=$1;

#echo "First temperature value";
#read a;
a=$2;

#echo "End temperature value";
#read b;
b=$3;

for ((i=$a;i<=$b;i+=$incre)) 
do 
cd $infile;
sed -i -e "s/\(ref_t = \).*/\1$i/" -e "s/\(gen_temp = \).*/\1$i/" *.mdp
cd ..
cp -r $infile "$out"_$i;
echo $i;
done; 

for ((i=$a;i<=$b;i+=$incre))
do 
cd "$out"_$i;
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
done
wait
