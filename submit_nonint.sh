#!/bin/bash
#This script will ask for 1.Folder containing one set of files 2.initial and 3.final temperature of the range needed.
#This script will generate folders at the increment of five degrees.

#nsteps=$1
#ref_temp_gen_temp=$2

incre=0.1;
out=WH2Z_Cter_f;
echo "Give the folder containing basic set of files";
read infile;

echo "First temperature value";
read a;

echo "End temperature value";
read b;
for i in $(seq ${a} ${incre} ${b}) 
do 
cd $infile;
sed -i -e "s/\(ref_t = \).*/\1$i/" -e "s/\(gen_temp = \).*/\1$i/" *.mdp
cd ..
cp -r $infile "$out"_$i;
echo ${i};
done; 

for i in $(seq ${a} ${incre} ${b})
do 
cd "$out"_$i;
sh SGE_script_pd.sh
cd ..
done
wait
