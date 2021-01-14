#!/bin/bash

name=Output;
extime=500000;

plutpbconv -s ${name}.tpr -o ${name}_new.tpr -until ${extime}
mv ${name}_new.tpr ${name}.tpr
nohup mpirun -np 4 plumdrun -deffnm ${name} -cpi ${name} -append -pd -plumed plumed.dat & 
