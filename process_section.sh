#!/bin/bash

# Author: Aaron Herting
# License: MIT


LOCK_FILE="/var/lock/slurmplot/$BASHPID"

mkdir -p /var/lock/slurmplot

touch $LOCK_FILE

while read line ; do
	JOB_ID=`echo "$line" | awk -F'|' '{ print $1 ; }'`
	PARTITION=`echo "$line" | awk -F'|' '{ print $2 ; }'`
	USERNAME=`echo "$line" | awk -F'|' '{ print $3 ; }'`
	ELAPSED=`echo "$line" | awk -F'|' '{ print $4 ; }'`
	SUBMIT=`echo "$line" | awk -F'|' '{ print $5 ; }'`
	START=`echo "$line" | awk -F'|' '{print $6 ; }'`
	END=`echo "$line" | awk -F'|' '{print $7 ; }'`
	
	U_SUBMIT=`echo "$SUBMIT" | date --file - '+%s'`
	U_START=`echo "$START" | date --file - '+%s'`
	U_END=`echo "$END" | date --file - '+%s'`

	S_ELAPSED=`echo -e "$U_END\t$U_START" | awk '{ print $1 - $2 ; }'`

# Calculate a "date stamp"
# 1. Take unix time
#	2. sec  -> min
# 3. min  -> hour
# 4. hour -> day
# 5. truncate
	D_START=`echo "$U_START" | awk '{ print ( $1 / ( 60 * 60 * 24 )) ; }' | awk -F'.' '{ print $1 }'`

	echo -e "$PARTITION\t$USERNAME\t$S_ELAPSED\t$U_SUBMIT\t$U_START\t$U_END" 
	
done

rm -f $LOCK_FILE

