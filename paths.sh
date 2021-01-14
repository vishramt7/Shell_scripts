#!/bin/bash


#for i in *.txt
#do 
#	for j in {1..100..1}
#	do 	
#	perl Contacts.CA.pl Output.tpr frames_${j}.xtc ${i}
#	done	
#rm *.Qi
#done 

#mkdir paths
pairs=$(awk 'END{print FNR}' pairs_top.txt)
for i in B1_B5_pairs.txt
do
Cont=$(awk 'END{print FNR}' ${i})
	for j in {1..100..1}
	{
	paste frames_${j}.xtc_pairs_top.txt.AA.Q frames_${j}.xtc_${i}.AA.Q | sort -nk1,1 | awk '{print $1/'${pairs}',$2/'${Cont}'}' >> ${i}.dat
	echo "&" >> ${i}.dat
	}
echo ${i} ${Cont}
done
