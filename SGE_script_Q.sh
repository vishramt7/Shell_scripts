#!/bin/bash
#$ -cwd 
#$ -N PHT_delNC
#$ -e PHT_delNC.errout
#$ -o PHT_delNCout.out
#$ -q all.q,parallel.q

# Create using mkdir /state/partition1/$USER ,folder on the node first
#mkdir /state/partition1/$USER
mkdir /state/partition1/$USER/$JOB_NAME-$JOB_ID/
cp $SGE_O_WORKDIR/Output.tpr $SGE_O_WORKDIR/Output.xtc $SGE_O_WORKDIR/*.pl $SGE_O_WORKDIR/*.txt /state/partition1/$USER/$JOB_NAME-$JOB_ID/.
cd /state/partition1/$USER/$JOB_NAME-$JOB_ID

perl Contacts.CA.pl Output.tpr Output.xtc pairs_top.txt 

cp /state/partition1/$USER/$JOB_NAME-$JOB_ID/*.Q* $SGE_O_WORKDIR/.
rm -r /state/partition1/$USER/$JOB_NAME-$JOB_ID
