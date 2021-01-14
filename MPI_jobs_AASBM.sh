#!/bin/bash
#$ -cwd
#$ -N Check
#$ -e Check.errout
#$ -o Check.out
#$ -q all.q@compute-0-10.local
#$ -pe mpich 4

mkdir /state/partition1/$USER/$JOB_NAME-$JOB_ID
cp $SGE_O_WORKDIR/*.gro $SGE_O_WORKDIR/*.top $SGE_O_WORKDIR/*.mdp /state/partition1/$USER/$JOB_NAME-$JOB_ID/.
cd /state/partition1/$USER/$JOB_NAME-$JOB_ID
grompp -f *.mdp -p *.top -c *.gro -o Output.tpr -po Output.mdp -maxwarn 1
mpirun -v -machinefile $TMPDIR/machines -np $NSLOTS mdrun -s Output.tpr -e Output.edr -g Output.log -cpo Output.cpt -o Output.trr -x Output.xtc -c Output.gro -pd 
cp /state/partition1/$USER/$JOB_NAME-$JOB_ID/* $SGE_O_WORKDIR/.
#rm -r /state/partition1/$USER/$JOB_NAME-$JOB_ID
