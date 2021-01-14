#!/bin/bash
#This script will generate plumed.dat files with a range of parameters

echo "Give the folder containing basic set of files";
read infile;

out=Out;
a=1
for pace in 500 5000 50000
do 
	for height in 0.1 0.5 1 
	do
		for sigma in 0.1 1 10 
		do 	
		cp -r ${infile} ${out}_${a};
		cd ${out}_${a};
		sed -i -e "s/\(PACE=\).*/\1${pace}/" -e "s/\(HEIGHT=\).*/\1${height}/" -e "s/\(SIGMA=\).*/\1${sigma}/" *.dat
		echo qsub MPI_jobs_PLUMED.sh
		cd ../
		echo Folder ${a} has PACE=${pace} HEIGHT=${height} SIGMA=${sigma}  >> log.txt
		a=$((a + 1))
		done
	done 
done 
