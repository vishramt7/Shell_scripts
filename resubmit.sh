#!/bin/bash

for cnt in {1..4..1};
do
     echo "performing extension of $cnt of 4"
     MYPWD=${PWD}
     FILENAME=$MYPWD/ca_fold_99.xtc
     FILESIZE=$(stat -c%s "$FILENAME")
     sub=5
     prevFILESIZE=$(($FILESIZE+$sub))
     # check to get the filesize of xtc into the variable
     #
     #  FILENAME=/home/heiko/dummy/packages.txt
     #  FILESIZE=$(stat -c%s "$FILENAME")
     # echo "Size of $FILENAME = $FILESIZE bytes."
     for a in {99..99..1};
     do
         cp sampleqsubmpi_extd.sge ca_fold_${a}.sge;
         sed -i s/xab/${a}/g ca_fold_${a}.sge;
         sed -i s/extendtime/1600000/g ca_fold_${a}.sge ;
         sed -i s/xNAME/stfA${a}ex/g ca_fold_${a}.sge;
         qsub ca_fold_${a}.sge
         echo "Run $cnt Size of $FILENAME = $FILESIZE bytes."
         #1600000.00000
     done
     while [ $prevFILESIZE -gt $FILESIZE ];
     do
         echo "sleeping to procced to the next step" ;
         FILENAME=$MYPWD/ca_fold_99.xtc
         FILESIZE=$(stat -c%s "$FILENAME")
         sleep 1h
         # sleep 3h hours, sleep 3d days
     done
     echo "sleeping for 30 min"
     sleep 20m
     # tail -1 ca_fold_99.log | awk '{if ($1=="Finished") print $1}'
     # check to see in the log file indicates no crash
     check=`tail -1 ca_fold_99.log | awk '{print $1}'`
     fin1="Finished"
     if expr match "$check" "$fin1" ; then
         echo "SUCCESS"
     else
         break
     fi

done
