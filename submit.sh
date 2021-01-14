#!/bin/bash
#This script will ask for 1.Folder containing one set of files 2.initial and 3.final temperature of the range needed.
#This script will generate folders at the increment of five degrees.

#nsteps=$1
#ref_temp_gen_temp=$2

incre=5;
out=Go;
echo "Give the folder containing basic set of files";
read infile;

echo "First temperature value";
read a;

echo "End temperature value";
read b;
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
grompp -f 2CI2_CA.mdp -c 2CI2_CA.gro -p 2CI2_CA.top -o 2CI2.tpr;
mdrun -s 2CI2.tpr -table 2CI2_CA.xvg -tablep 2CI2_CA.xvg -v &
cd ..
done
wait

#mkdir "/home/labuser/Desktop/OUTPUT$2"
#WORKDIR="/home/labuser/Desktop/OUTPUT$2"
#MYDIR="/home/labuser/Vishram/MD/2014_3_2/Submission"

#sed -i -e "s/\(nsteps =\).*/\1$1/" -e "s/\(ref_t=\).*/\1$2/" -e "s/\(gen_temp=\).*/\1$2/" md.mdp

#grompp -f md.mdp -c 2CI2_new_mmtsb.gro -p 2CI2_mmtsb_GO.top -o try.tpr

#mdrun -s try.tpr -tableb Table.xvg -v
#cp -r $MYDIR $WORKDIR
