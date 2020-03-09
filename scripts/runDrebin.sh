#!/bin/bash

# Run Drebin a given number of times, currently with a random training/testing split
# TODO: make the training/testing splits not random, to allow comparison across 
# different tools.

# Currently not working... something with the directory structure, or just a stupid bash error?

drebinDir=$1
malwareDir=$2
goodwareDir=$3
numIterations=$4

pythonMain="${drebinDir}Main.py"

echo "$pythonMain"

for i in $(seq 1 $numIterations)
do
	python ${pythonDir} --holdout 0 --maldir ${malwareDir} --gooddir ${goodwareDir}
done
