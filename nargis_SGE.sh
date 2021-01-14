#!/bin/bash -l
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -N K7X
#$ -pe orte 2
#$ -o K7Xout.out
#$ -e K7Xerror.out
#$ -q all.q

echo "Starting MPI job at: " `date`
echo "Starting MPI job on: " `hostname`
echo "Total cores demanded: " $NSLOTS
echo "Job name given: " $JOB_NAME
echo "Job ID: " $JOB_ID
echo "Starting MPI job..."

grompp -f *.mdp -p *.top -c *.gro -o Output.tpr -po Output.mdp
mpirun -np $NSLOTS mdrun -s Output.tpr -o Output.trr -x Output.xtc -cpo Output.cpt -c Output.gro -e Output.edr -g Output.log -table pair_table.xvg -tablep pair_table.xvg -pd

sleep 10
