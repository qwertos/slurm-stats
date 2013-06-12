#!/bin/bash


cat | awk -F'\t' '{ print $3 ; }' | sort | uniq 


