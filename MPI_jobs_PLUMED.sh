#!/bin/bash
#$ -cwd
#$ -N Check
#$ -e Check.errout
#$ -o Check.out
#$ -q all.q,parallel.q
#$ -pe mpich 4

set PLUGMX=/home/vishramlt/PLUGMX_455/bin
mkdir /state/partition1/$USER/$JOB_NAME-$JOB_ID
cp $SGE_O_WORKDIR/* /state/partition1/$USER/$JOB_NAME-$JOB_ID/.
cd /state/partition1/$USER/$JOB_NAME-$JOB_ID
$PLUGMX/plugrompp -f *.mdp -p *.top -c *.gro -o Output.tpr -po Output.mdp -maxwarn 1
mpirun -v -machinefile $TMPDIR/machines -np $NSLOTS $PLUGMX/plumdrun -s Output.tpr -e Output.edr -g Output.log -cpo Output.cpt -o Output.trr -x Output.xtc -c Output.gro -pd -plumed plumed.dat
cp /state/partition1/$USER/$JOB_NAME-$JOB_ID/* $SGE_O_WORKDIR/.
#rm -r /state/partition1/$USER/$JOB_NAME-$JOB_ID
