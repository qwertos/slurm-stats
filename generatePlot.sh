#!/bin/bash

# Author: Aaron Herting
# License: MIT

TMP_DIR="/dev/shm/accounting"
CORES_TO_USE=9


# Ensure tmpdir is in exastince
mkdir -p $TMP_DIR
touch $TMP_DIR/unstandard.psv
touch $TMP_DIR/account.dat

# Collect accounting data
sacct -L -P --starttime=0601  --format=jobid,partition,user,elapsed,submit,start,end | tail -n +2 > $TMP_DIR/unstandard.psv

mkdir -p $TMP_DIR/unstandard.psv.d/
split -n "l/$CORES_TO_USE" -d $TMP_DIR/unstandard.psv $TMP_DIR/unstandard.psv.d/

for file in $TMP_DIR/unstandard.psv.d/* ; do
	cat $file | process_section.sh >> $TMP_DIR/account.dat &
done

		

