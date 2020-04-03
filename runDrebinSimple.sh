#!/bin/bash

if [ ! -d drebin ] ; then
	echo "Drebin project not found! Please run getAllTools.sh to obtain Drebin before running this script!"
	exit 1
fi

mkdir -p output
mkdir -p output/drebin

./scripts/runDrebin.sh drebin output/drebin util/modelNamesDrebin.txt
