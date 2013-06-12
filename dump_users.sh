#!/bin/bash


# Author: Aaron Herting
# License: MIT


LOCK_FILE="/var/lock/slurmplot/$BASHPID"

mkdir -p /var/lock/slurmplot

touch $LOCK_FILE

cat | awk -F'\t' '{ print $2 ; }' | sort | uniq 


rm -f $LOCK_FILE

