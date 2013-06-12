#!/bin/bash

# Author: Aaron Herting
# License: MIT

while read line ; do
	JOB_ID=`echo "$line" | cut -d'|' -f1`
	PARTITION=`echo "$line" | cut -d'|' -f2`
	USERNAME=`echo "$line" | cut -d'|' -f3`
	ELAPSED=`echo "$line" | cut -d'|' -f4`
	SUBMIT=`echo "$line" | cut -d'|' -f5`
	START=`echo "$line" | cut -d'|' -f6`
	END=`echo "$line" | cut -d'|' -f7`
	
	U_SUBMIT=`echo "$SUBMIT" | date --file - '+%s'`
	U_START=`echo "$START" | date --file - '+%s'`
	U_END=`echo "$END" | date --file - '+%s'`

	S_ELAPSED=`echo -e "$U_END\t$U_START" | awk '{ print $1 - $2 ; }'`

	echo -e "$PARTITION\t$USERNAME\t$S_ELAPSED\t$U_SUBMIT\t$U_START\t$U_END" 
	
done


