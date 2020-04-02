#!/bin/bash

# Run Drebin a given number of times, currently with a random training/testing split
# TODO: make the training/testing splits not random, to allow comparison across 
# different tools.

# Currently not working... something with the directory structure, or just a stupid bash error?

drebinDir="$1/src/"
malwareDir=$(realpath $2)
goodwareDir=$(realpath $3)
numIterations=$4

currentDir=$(pwd)

modulePath=$(realpath "${drebinDir}/Modules/")
androguardPath=$(realpath "${drebinDir}/Androguard/")
drebinPath="${modulePath}:${androguardPath}"

pythonMain="Main.py"

echo "$pythonMain"

cd "${drebinDir}" || { printf "cd failed (invalid drebin directory provided), exiting\n" >&2;  return 1; }

for i in $(seq 1 "$numIterations")
do
	PYTHONPATH="${drebinPath}" python "${pythonMain}" --holdout 0 --maldir "${malwareDir}" --gooddir "${goodwareDir}" --model "drebin${i}"
done

cd "${currentDir}" || { printf "cd failed??? (this should not happen), exiting\n" >&2;  return 1; }
