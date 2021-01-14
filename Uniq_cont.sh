#!bin/bash

echo "This script takes two inputs and gives COMMON AND UNIQUE enteries of each"

name=$(basename ${1} .dat)

grep -w -f ${1} ${2} | awk '{print $2,$4,0.2}' > ${1}_${2}_common.dat
grep -w -v -f ${1} ${2} | awk '{print $2,$4,0.5}' > ${2}_uniq
grep -w -v -f ${2} ${1} | awk '{print $2,$4,1.0}' > ${1}_uniq
cat ${2}_uniq ${1}_uniq ${1}_${2}_common.dat | sort -nk1,1 -nk2,2 > Uniq.cmap

perl Native_Contact_map.pl Uniq.cmap 76 Uniq_cmap.dat

echo Uniq_cmap.dat | matlab -nodesktop -nosplash -r "Contact_map;quit;"
