#!/bin/bash -l
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -N ClyA
#$ -pe orte 32
#$ -o result.out
#$ -e error.out
#$ -q all.q

echo "Starting MPI job at: " `date`
echo "Starting MPI job on: " `hostname`
echo "Total cores demanded: " $NSLOTS
echo "Job name given: " $JOB_NAME
echo "Job ID: " $JOB_ID
echo "Starting MPI job..."

export GMXPATH=/home/hemanthg/gromacs4.5.4_newplumed_mpi/bin/
export GMXLIB=/cluster/share/hemanthg/ClyA/1QOY/folding_study/plumed/US/kappa_0.02/biasx_125/replex_5ps_biasxfixed_32repl_replicate1/gaussian_contact_tables/
mpirun -np $NSLOTS $GMXPATH/mdrun_mpi -s 1QOY-SBM-MD_GMX4.5-plumed.tpr -tableb 1QOY-SBM-MD_GMX4.5-plumed.xvg -o 1QOY-SBM-MD_GMX4.5-plumed.trr -x 1QOY-SBM-MD_GMX4.5-plumed.xtc -cpo 1QOY-SBM-MD_GMX4.5-plumed.cpt -c 1QOY-SBM-MD_GMX4.5-plumed.gro -e 1QOY-SBM-MD_GMX4.5-plumed.edr -g 1QOY-SBM-MD_GMX4.5-plumed.log -plumed 1QOY-SBM-MD_GMX4.5-plumed.dat -multi 32 -replex 10000 -pd

sleep 10
