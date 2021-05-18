#usr/bin/bash
#This script will extract the most folded structure from the simulation
#The input is .Q file

name=$1;
A=$(cat ${name} | sort -nrk1,1 | head -n1);
B=$(awk '{if ($1=='${A}') print NR}' ${name});

echo -e "[ frames ]\n${B}" > frames.ndx
echo 1 | trjconv -f Output.xtc -s Output.tpr -fr frames.ndx -o folded.gro
editconf -f folded.gro -o folded.pdb

egrep -v "@|#|&" energy.xvg | awk '{print $2}' > energy.txt
egrep -v "@|#|&" rmsd.xvg | awk '{print $2}' > rmsd.txt

C=$(awk '{if (NR=='${B}') print}' energy.txt);
D=$(awk '{if (NR=='${B}') print}' rmsd.txt);

echo "The energy for the structure is ${C}";
echo "The rmsd of the structure is ${D}";
echo "This is a check"
