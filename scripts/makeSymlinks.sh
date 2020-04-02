#!/bin/bash

# This script creates directories for each training/testing partition
# and populates them with symbolic links to the actual apks.
#
# The choice of which apks have symbolic links in which testing/training
# directory is determined by the text files in the /partitions/ directory

mkdir -p data-partitions
mkdir -p data-partitions/goodware
mkdir -p data-partitions/malware


for i in {1..5}
do
	echo "Creating partitions in group ${i} of 5"

	testingName="testing_${i}"
	trainingName="training_${i}"
	mkdir -p data-partitions/goodware/${testingName}
	mkdir -p data-partitions/malware/${testingName}
	mkdir -p data-partitions/goodware/${trainingName}
        mkdir -p data-partitions/malware/${trainingName}

	echo "Making symbolic links in data-partitions/goodware/${testingName}"
	while IFS="" read -r apk || [ -n "$apk" ]
	do
		ln -sf $(realpath goodware/${apk}) data-partitions/goodware/${testingName} 
	done < partitions/goodware/${testingName}.txt

	echo "Making symbolic links in data-partitions/malware/${testingName}"
	while IFS="" read -r apk || [ -n "$apk" ]
        do
                ln -sf $(realpath malware/${apk}) data-partitions/malware/${testingName}
        done < partitions/malware/${testingName}.txt

	echo "Making symbolic links in data-partitions/goodware/${trainingName}"
	while IFS="" read -r apk || [ -n "$apk" ]
        do
                ln -sf $(realpath goodware/${apk}) data-partitions/goodware/${trainingName}
        done < partitions/goodware/${trainingName}.txt

	echo "Making symbolic links in data-partitions/malware/${trainingName}"
	while IFS="" read -r apk || [ -n "$apk" ]
        do
                ln -sf $(realpath malware/${apk}) data-partitions/malware/${trainingName}
        done < partitions/malware/${trainingName}.txt
done
