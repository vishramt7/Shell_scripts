#!/bin/bash
#$ -cwd 
#$ -N TIQ
#$ -e TIQ.errout
#$ -o TIQout.out
#$ -q all.q,parallel.q
#$ -pe mpich 4 

mkdir /state/partition1/$USER/
mkdir /state/partition1/$USER/$JOB_NAME-$JOB_ID/
cp $SGE_O_WORKDIR/*.gro $SGE_O_WORKDIR/*.top $SGE_O_WORKDIR/*.mdp $SGE_O_WORKDIR/*.xvg /state/partition1/$USER/$JOB_NAME-$JOB_ID/.
cd /state/partition1/$USER/$JOB_NAME-$JOB_ID
grompp -f *.mdp -p *.top -c *.gro -o Output.tpr -po Output.mdp
mpirun -v -machinefile $TMPDIR/machines -np $NSLOTS mdrun -s Output.tpr -o Output.trr -x Output.xtc -cpo Output.cpt -c Output.gro -e Output.edr -g Output.log -table pair_table.xvg -tablep pair_table.xvg -pd -maxh 47.5
cp /state/partition1/$USER/$JOB_NAME-$JOB_ID/Output* $SGE_O_WORKDIR/.
rm -r /state/partition1/$USER/$JOB_NAME-$JOB_ID
