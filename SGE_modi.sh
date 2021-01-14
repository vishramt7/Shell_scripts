#!/bin/bash
#$ -cwd 
#$ -N Fegp3
#$ -e Fegp3.errout
#$ -o Fegp3out.out
#$ -q all.q@compute-0-11.local 

# Create using mkdir /state/partition1/$USER ,folder on the node first
#mkdir /state/partition1/$USER
mkdir /state/partition1/$USER/$JOB_NAME-$JOB_ID/
cp $SGE_O_WORKDIR/* /state/partition1/$USER/$JOB_NAME-$JOB_ID/.
cd /state/partition1/$USER/$JOB_NAME-$JOB_ID

foreach x (0 1 2 3 4 5 6 7 8 9 10)
        perl Contmap_BB_CB.pl $x
end

cp /state/partition1/$USER/$JOB_NAME-$JOB_ID/* $SGE_O_WORKDIR/.
#rm -r /state/partition1/$USER/$JOB_NAME-$JOB_ID
# Do not leave files on the nodes
