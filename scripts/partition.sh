#!/bin/bash

# This script creates 5 new random partitions for the training/testing.
# Running this script will overwrite any existing partitions for the project.

originalDir=$(pwd)

cd ../goodware

echo "Creating partitions for benign apks"

# Write the names of all the benign apks to the txt file
for apkName in *.apk ; do
	echo "${apkName}" >> names.txt
done

totalApks=$(find ./ -name "*.apk" | wc -l)
numTrainingApks=$(python3 -c "print(round(${totalApks}*0.7))")
partitionPath="../partitions/goodware/"

# Do the following 5 times:
for i in {1..5} ; do

	if [[ -f ${partitionPath}training_${i}.txt ]] ; then
        	rm ${partitionPath}training_${i}.txt
	fi

	if [[ -f ${partitionPath}testing_${i}.txt ]] ; then
                rm ${partitionPath}testing_${i}.txt
        fi

	# Get a random 30% of benign apks for the training set using shuf -n <30%>
	find ./ -name "*.apk" -printf "%f\n" | shuf -n "${numTrainingApks}" > ${partitionPath}training_${i}.txt

	# grep the training apk lines from the training file, and construct the complementary testing file
	grep -F -v -f ${partitionPath}training_${i}.txt names.txt > ${partitionPath}testing_${i}.txt

done

rm names.txt

# repeat the process for malicious apks

cd ../malware

echo "Creating partitions for malicious apks"

for apkName in * ; do
	if [[ $apkName == !(*.*) ]] ; then
        	echo "${apkName}" >> names.txt
	fi
done

totalApks=$(find ./ ! -name "*.*" | wc -l)
numTrainingApks=$(python3 -c "print(round(${totalApks}*0.7))")
partitionPath="../partitions/malware/"

# Do the following 5 times:
for i in {1..5} ; do

        if [[ -f ${partitionPath}training_${i}.txt ]] ; then
                rm ${partitionPath}training_${i}.txt
        fi

        if [[ -f ${partitionPath}testing_${i}.txt ]] ; then
                rm ${partitionPath}testing_${i}.txt
        fi

        # Get a random 30% of benign apks for the training set using shuf -n <30%>
        find ./ ! -name "*.*" -printf "%f\n" | shuf -n "${numTrainingApks}" > ${partitionPath}training_${i}.txt

        # grep the training apk lines from the training file, and construct the complementary testing file
        grep -F -v -f ${partitionPath}training_${i}.txt names.txt > ${partitionPath}testing_${i}.txt

done

rm names.txt

echo "Done!"

cd "${originalDir}"
