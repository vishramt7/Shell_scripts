#!/bin/bash
#The script extends simulation with deffnm Output
#The number of iterations can be controlled by variable iterate
#The maxh can also be controlled


iterate=10; 
name=Output;
extime=200;
maxhr=0.02;
echo "This name is ${name} time is ${extime}";

tpbconv -s ${name}.tpr -o ${name}_new.tpr -extend ${extime}
mv ${name}_new.tpr ${name}.tpr
mdrun -deffnm ${name} -cpi ${name}.cpt -append -maxh ${maxhr} -pd -nt 1 -v 

for ((i=1;i<=${iterate};i++))
do
	count=$(wc -l ${name}.log | awk '{print $1}')
	mdrun -deffnm ${name} -cpi ${name}.cpt -append -maxh ${maxhr} -pd -nt 1 -v
	check=$(grep -wc "Finished mdrun" ${name}.log)
	count1=$(wc -l ${name}.log | awk '{print $1}')
	echo "This is the iteration ${i}"
		if [ ${count1} -eq ${count} -a ${check} -eq 1 ]
		then
			echo "SIMULATION IS COMPLETE!!!"
			break 
		elif [${check} -gt 1]
		then 
			echo "WARNING:MORE THAN ONE OCCURENCE FOR FINISHED MDRUN: EXITING!!!"
			break
		else
			echo "Extending the Simulation"
		fi
done
