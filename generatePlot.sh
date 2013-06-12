#!/bin/bash

# Author: Aaron Herting
# License: MIT

TMP_DIR="/dev/shm/accounting"


# Ensure tmpdir is in exastince
mkdir -p $TMP_DIR
touch $TMP_DIR/unstandard.psv

# Collect accounting data
sacct -L -P --starttime=0601  --format=jobid,partition,user,elapsed,submit,start,end | tail -n +2 > $TMP_DIR/unstandard.psv



