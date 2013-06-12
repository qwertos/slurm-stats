#!/bin/bash


cat | awk -F'\t' '{ print $2 ; }' | sort | uniq 


