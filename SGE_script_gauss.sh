#!/bin/bash
#$ -cwd 
#$ -N UBQ
#$ -e UBQ.errout
#$ -o UBQout.out
#$ -q all.q,parallel.q 

set GAUSSGMX=/home/vishramlt/GAUSSGMX_454/bin
mkdir /state/partition1/$USER/$JOB_NAME-$JOB_ID/
cp $SGE_O_WORKDIR/*.gro $SGE_O_WORKDIR/*.top $SGE_O_WORKDIR/*.mdp $SGE_O_WORKDIR/*.xvg /state/partition1/$USER/$JOB_NAME-$JOB_ID/.
cd /state/partition1/$USER/$JOB_NAME-$JOB_ID
${GAUSSGMX}/gaussgrompp -f *.mdp -p *.top -c *.gro -o Output.tpr -po Output.mdp
${GAUSSGMX}/gaussmdrun -s Output.tpr -o Output.trr -x Output.xtc -cpo Output.cpt -c Output.gro -e Output.edr -g Output.log
cp /state/partition1/$USER/$JOB_NAME-$JOB_ID/Output* $SGE_O_WORKDIR/.
rm -r /state/partition1/$USER/$JOB_NAME-$JOB_ID
