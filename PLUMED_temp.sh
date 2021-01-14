#!/bin/bash

proc=2;
plugrompp -f *.mdp -p *.top -c *.gro -o Output.tpr -po Output.mdp -maxwarn 1
export PLUMED_NUM_THREADS=${proc}
mpirun -np ${proc} plumdrun -s Output.tpr -e Output.edr -g Output.log -cpo Output.cpt -o Output.trr -x Output.xtc -c Output.gro -pd -plumed plumed.dat
