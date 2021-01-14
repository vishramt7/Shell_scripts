#!/bin/bash
#$ -cwd
#$ -N 2CI2
#$ -e 2CI2.errout
#$ -o 2CI2out.out
#$ -q all.q@compute-0-1.local #, all.q@compute-0-8.local,all.q@compute-0-9.local #,parallel.q@compute-0-12.local#,all.q@compute-0-10.local
# -pe mpich 16
#
# *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *
#
mkdir /state/partition1/$USER/
mkdir /state/partition1/$USER/$JOB_NAME-$JOB_ID/
# if extending
#
# cp $SGE_O_WORKDIR/ca_fold_xab* $SGE_O_WORKDIR/foldxabT* $SGE_O_WORKDIR/kseunfolded.pdb $SGE_O_WORKDIR/table.xvg $SGE_O_WORKDIR/ksetop.top /state/partition1/$USER/$JOB_NAME-$JOB_ID/.
#
# /home/nahrenm/nahgro/bin/newmdrun -s foldxabT.tpr -c foldxabT.pdb -o foldxabT.trr -x foldxabT.xtc -g foldxabT.log -e foldxabT.edr -cpo foldxabT.cpt  -table table.xvg -tablep table.xvg -append -cpi foldxabT.cpt
#
cp $SGE_O_WORKDIR/2CI2.gro $SGE_O_WORKDIR/2CI2.top $SGE_O_WORKDIR/2CI2.mdp $SGE_O_WORKDIR/pair_table.xvg /state/partition1/$USER/$JOB_NAME-$JOB_ID/.
sleep 3
cd  /state/partition1/$USER/$JOB_NAME-$JOB_ID
sleep 2
grompp -f *.mdp -p *.top -c *.gro  -o Output.tpr -po Output.mdp
#python difftemppy.py 139 139 1 sample.mdp 4 4n6vtop.top stfbunfolded.pdb
sleep 2
mdrun -s Output.tpr -o Output.tpr -x Output.xtc -cpo Output.cpt -c Output.gro -e Output.edr -g Output.log -table pair_table.xvg -tablep pair_table.xvg
cp  /state/partition1/$USER/$JOB_NAME-$JOB_ID/Output* $SGE_O_WORKDIR/.
sleep 2
#rm -r /state/partition1/$USER/$JOB_NAME-$JOB_ID

