#!/bin/bash
#$ -cwd 
#$ -N Check
#$ -e Check.errout
#$ -o Checkout.out
#$ -q all.q

set name=Output;		 
set extime=200000;	# in ps
set maxhr=1;		# in hr

#mkdir /state/partition1/$USER
mkdir /state/partition1/$USER/$JOB_NAME-$JOB_ID/
cp $SGE_O_WORKDIR/${name}* $SGE_O_WORKDIR/*.xvg /state/partition1/$USER/$JOB_NAME-$JOB_ID/.
cd /state/partition1/$USER/$JOB_NAME-$JOB_ID

tpbconv -s ${name}.tpr -o ${name}_new.tpr -until ${extime}
mv ${name}_new.tpr ${name}.tpr
mdrun -deffnm ${name} -cpi ${name} -append -table pair_table.xvg -tablep pair_table.xvg -maxh ${maxhr} 

cp /state/partition1/$USER/$JOB_NAME-$JOB_ID/${name}* $SGE_O_WORKDIR/.
rm -r /state/partition1/$USER/$JOB_NAME-$JOB_ID
