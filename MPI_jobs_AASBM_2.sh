#!/bin/bash
#$ -cwd 
#$ -N Check
#$ -e Check.errout
#$ -o Checkout.out
#$ -q all.q,parallel.q
#$ -pe mpich 4

set name=Output;		 
set extime=100000;	# in ps
set maxhr=47.5;		# in hr

#mkdir /state/partition1/$USER
mkdir /state/partition1/$USER/$JOB_NAME-$JOB_ID/
cp $SGE_O_WORKDIR/* /state/partition1/$USER/$JOB_NAME-$JOB_ID/.
cd /state/partition1/$USER/$JOB_NAME-$JOB_ID

tpbconv -s ${name}.tpr -o ${name}_new.tpr -until ${extime}
mv ${name}_new.tpr ${name}.tpr
mpirun -v -machinefile $TMPDIR/machines -np $NSLOTS mdrun -deffnm ${name} -cpi ${name} -append -maxh ${maxhr} -pd

cp /state/partition1/$USER/$JOB_NAME-$JOB_ID/* $SGE_O_WORKDIR/.
#rm -r /state/partition1/$USER/$JOB_NAME-$JOB_ID
