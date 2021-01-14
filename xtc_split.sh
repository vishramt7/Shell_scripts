#!usr/bin/bash

echo "This script will split a big .xtc into pieces and get .Q and .Qi file"

tpr=$1;
xtc=$2;
pairs=$3;

#echo ".tpr file is ${tpr} and .xtc file is ${xtc}"
echo 0 | trjconv -f ${xtc} -s ${tpr} -split 50000 -o split 

files=$(ls split*.xtc | wc -l)
echo "Total files generated are ${files}"
	for ((i=0;i<${files};i++))
	{	
	perl Contacts.AA_short.pl ${tpr} split${i}.xtc ${pairs}
	rm split${i}.xtc
	echo "Processing file ${i}"
	}

	for ((j=0;j<${files};j++))
	{
	cat split${j}.xtc.AA.Q >> SPLIT.Q
	cat split${j}.xtc.AA.Qi >> SPLIT.Qi
	}
rm split*
