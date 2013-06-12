#!/bin/bash

# Author: Aaron Herting
# License: MIT

TMP_DIR="/dev/shm/accounting"
CORES_TO_USE=9


# Ensure tmpdir is in exastince
mkdir -p $TMP_DIR
touch $TMP_DIR/unstandard.psv

# Collect accounting data
sacct -L -P --starttime=0601  --format=jobid,partition,user,elapsed,submit,start,end | tail -n +2 > $TMP_DIR/unstandard.psv

mkdir -p $TMP_DIR/unstandard.psv.d/


#split -n "l/$CORES_TO_USE" -d $TMP_DIR/unstandard.psv $TMP_DIR/unstandard.psv.d/
LINES=`wc -l $TMP_DIR/unstandard.psv | awk '{ print $1 ; }'`
LINES_PER=`echo -e "$CORES_TO_USE\t$LINES" | awk '{ print $2 / ( $1 - 1 ) ;}' | awk -F. '{ print $1; }'`
echo $CORES_TO_USE
echo $LINES
echo $LINES_PER

split -l "$LINES_PER" -d $TMP_DIR/unstandard.psv $TMP_DIR/unstandard.psv.d/


mkdir -p /var/lock/slurmplot

rm $TMP_DIR/account.dat
touch $TMP_DIR/account.dat
for file in $TMP_DIR/unstandard.psv.d/* ; do
	cat $file | ./process_section.sh >> $TMP_DIR/account.dat &
done

while [[ -n `ls /var/lock/slurmplot` ]] ; do
	sleep 10
done


# list users
rm $TMP_DIR/users.txt
touch $TMP_DIR/users.txt

for file in $TMP_DIR/unstandard.psv.d/* ; do
	cat $file | ./dump_users.sh >> $TMP_DIR/users.txt &
done


while [[ -n `ls /var/lock/slurmplot` ]] ; do
	sleep 10
done

mv $TMP_DIR/users.txt $TMP_DIR/users.txt.old

cat $TMP_DIR/users.txt.old | sort | uniq > $TMP_DIR/users.txt



# Pull User data
mkdir -p $TMP_DIR/userData




		

