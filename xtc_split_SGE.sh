#!/bin/bash
#$ -cwd 
#$ -N SPLIT
#$ -e SPLIT.errout
#$ -o SPLITout.out
#$ -q all.q@compute-0-4.local

set xtc=Output.xtc
set tpr=Output.tpr
set pairs=pairs_top.txt
set out=split

mkdir /state/partition1/$USER/$JOB_NAME-$JOB_ID/
cp $SGE_O_WORKDIR/${tpr} $SGE_O_WORKDIR/${xtc} $SGE_O_WORKDIR/*.pl $SGE_O_WORKDIR/${pairs} /state/partition1/$USER/$JOB_NAME-$JOB_ID/.
cd /state/partition1/$USER/$JOB_NAME-$JOB_ID

echo 0 | trjconv -f ${xtc} -s ${tpr} -split 100000 -o ${out} 

set files=`ls split*.xtc | wc -l`
echo "Total files generated are ${files}"

set i=0
	while ($i<${files})
		perl Contacts.AA_short.pl ${tpr} ${out}${i}.xtc ${pairs}
		rm ${out}${i}.xtc
		echo "Processing file ${i}"
		@ i++
	end

set j=0
	while ($j<${files})
		cat ${out}${j}.xtc.AA.Q >> ${out}_SPLIT.Q
		cat ${out}${j}.xtc.AA.Qi >> ${out}_SPLIT.Qi
		@ j++
	end

cp /state/partition1/$USER/$JOB_NAME-$JOB_ID/${out}* $SGE_O_WORKDIR/.
rm -r /state/partition1/$USER/$JOB_NAME-$JOB_ID
