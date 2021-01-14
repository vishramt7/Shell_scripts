#!/bin/bash
#$ -cwd
#$ -N Check
#$ -e Check.errout
#$ -o Check.out
#$ -q all.q@compute-0-10.local
#$ -pe mpich 4

mkdir /state/partition1/$USER/$JOB_NAME-$JOB_ID
cp $SGE_O_WORKDIR/Output*.* /state/partition1/$USER/$JOB_NAME-$JOB_ID/.
cd /state/partition1/$USER/$JOB_NAME-$JOB_ID
tpbconv -s Output.tpr -o Output_new.tpr -extend 150000
mpirun -v -machinefile $TMPDIR/machines -np $NSLOTS mdrun -s Output_new.tpr -cpi Output.cpt -e Output.edr -g Output.log -cpo Output_new.cpt -o Output.trr -x Output.xtc -c Output_new.gro -append -pd 
cp  /state/partition1/$USER/$JOB_NAME-$JOB_ID/* $SGE_O_WORKDIR/.
#rm -r /state/partition1/$USER/$JOB_NAME-$JOB_ID
