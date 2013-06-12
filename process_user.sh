#!/bin/bash

# Author: Aaron Herting
# License: MIT

LOCK_FILE="/var/lock/slurmplot/$BASHPID"
USERNAME="$1"
USER_LIST="$2"

rm -f $LOCK_FILE


