#!/bin/bash

# This script does everything required to obtain the set of benign APKs needed to
# reproduce the experiments.  Requires API access to Androzoo.
# make sure you have a .az file in your home directory, configured
# with the following two lines:
#
# key=%YOUR_API_KEY%
# input_file=./AZList.csv

# !!!!!!!!! WARNING !!!!!!!!!
# Running this script will download nearly 300GB of Android APKs
# and may take several hours or even days to finish!
# !!!!!!!!! WARNING !!!!!!!!!

scriptDirectory=$(dirname "$0")
if [ ! -f "${scriptDirectory}/AZList.csv" ]; then
	curl -o AZList.csv.gz https://androzoo.uni.lu/static/lists/latest.csv.gz
	gunzip AZList.csv.gz
fi

downloadDir=$1

# Make the goodware directory if it doesn't already exist
mkdir -p ${downloadDir}

if [ -n "$(ls -A ${downloadDir})" ]; then
        echo "Please ensure the goodware directory is empty before running this script ($0)"
        exit 1
fi

# If Androzoo python app is not installed, install it
isAZInstalled=$[ -n $(pip3 list 2>/dev/null | grep azoo | echo) ]
if [ ! $isAZInstalled ]; then
	pip3 install azoo
fi


# Run the big scary download command.
# Please do not increase the -t option.
# (Androzoo has kindly requested that users perform no more than 20 concurrent downloads)
az -n 100000 -d 2010-08-01:2012-10-31 -vt 0:0 -t 20 -sd 1881690637321243411 -o ${downloadDir}
