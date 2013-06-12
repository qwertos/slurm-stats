#!/bin/bash


# Author: Aaron Herting
# License: MIT


LOCK_FILE="/var/lock/slurmplot/$BASHPID"

mkdir -p /var/lock/slurmplot

touch $LOCK_FILE


( while read line ; do
	echo $line | awk -F'|' '{ print $3 ; }' 
done ) | sort | uniq



rm -f $LOCK_FILE

