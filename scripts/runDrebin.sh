#!/bin/bash

# Run Drebin a given number of times, currently with a random training/testing split
# TODO: make the training/testing splits not random, to allow comparison across 
# different tools.

# Currently not working... something with the directory structure, or just a stupid bash error?

drebinDir=$1
malwareDir=$2
goodwareDir=$3
numIterations=$4

currentDir=$(pwd)
androguardPath="$HOME/malware-classification/drebin/src/Androguard/"

pythonMain="Main.py"

echo "$pythonMain"

cd "${drebinDir}" || { printf "cd failed (invalid drebin directory provided), exiting\n" >&2;  return 1; }

for i in $(seq 1 "$numIterations")
do
	PYTHONPATH="${androguardPath}" python "${pythonMain}" --holdout 0 --maldir "${malwareDir}" --gooddir "${goodwareDir}"
done

cd "${currentDir}" || { printf "cd failed??? (this should not happen), exiting\n" >&2;  return 1; }
