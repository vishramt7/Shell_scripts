#!/bin/bash
#This script will submit jobs to local pc for quenching simulations
#This script needs two folders containing input files, 1. all the .gro files and 2. containing all files except the .gro file

echo "Give the folder name containing set of files excluding the .gro files";
read infolder;
var=$(pwd);

echo "Give the folder containing all the .gro files";
read grofolder;

cd $grofolder
let count=0;
let max_jobs=5;
for i in *.gro;
do
mkdir $var/"Chan"_$count;
cp $i $var/"Chan"_$count;
cp $var/$infolder/* $var/"Chan"_$count; 

cd $var/"Chan"_$count;
grompp -f *.mdp -c *.gro -p *.top -o Output.tpr
mdrun -s Output.tpr -table pair_table.xvg -tablep pair_table.xvg -tableb table &
cd $var/$grofolder;
	if (($count % max_jobs==0));then
	echo "wait for background jobs to complete"
	wait 
	fi

let count=count+1;
done 
wait
#echo "$count";
