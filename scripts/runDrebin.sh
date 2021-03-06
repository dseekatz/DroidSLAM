#!/bin/bash

# Run Drebin 5 times, once with each pre-determined training/testing split

drebinDir="$1/src/"
outputDir=$2
modelNamesFile=$(realpath $3)

currentDir=$(pwd)

modulePath=$(realpath "${drebinDir}/Modules/")
androguardPath=$(realpath "${drebinDir}/Androguard/")
drebinPath="${modulePath}:${androguardPath}"

pythonMain="Main.py"

cd "${drebinDir}" || { printf "cd failed (invalid drebin directory provided), exiting\n" >&2;  return 1; }

for i in {1..5}
do
	echo "Running Drebin on partition ${i} of 5"

	malwareTrainingDir=../../data-partitions/malware/training_${i}
	goodwareTrainingDir=../../data-partitions/goodware/training_${i}
	malwareTestingDir=../../data-partitions/malware/testing_${i}
	goodwareTestingDir=../../data-partitions/goodware/testing_${i}

	PYTHONPATH="${drebinPath}" python "${pythonMain}" --holdout 1 --maldir "${malwareTrainingDir}" --gooddir "${goodwareTrainingDir}" --testmaldir "${malwareTestingDir}" --testgooddir "${goodwareTestingDir}" <${modelNamesFile} 1>../../${outputDir}/drebin${i}.out 2>&1
done

cd "${currentDir}" || { printf "cd failed??? (this should not happen), exiting\n" >&2;  return 1; }
