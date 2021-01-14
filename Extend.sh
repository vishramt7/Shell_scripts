#!/bin/bash
#The script extends simulation with deffnm Output
#The number of iterations can be controlled by variable iterate

iterate=2; 
for ((i=1;i<=${iterate};i++))
do
a=0;
	echo "This is the iteration ${i}"
	qsub SGE_script_2.sh > jid.txt
	jid=$(grep -o "[0-9]*" jid.txt)
	sleep 60			# This is for the script to submit itself
		while [ $a -eq 0 ]
		do 
			if  qstat | grep -w "${jid}"  
			then
				a=0
				sleep 60
				echo "PID ${jid} is running"
			else
				a=1
				echo "COMPLETE"
				break
			fi
		done
	sleep 60	
done
rm jid.txt
