#!/bin/bash

# Running the required mudflow analysis before applying the classifier
# For now, just a playground to figure out how this stuff works

# This should be provided as an argument and not hardcoded?
androidPlatforms="$ANDROID_HOME/platforms"

dirToAnalyze=$(realpath -s $1)
originalDir=$(pwd)

cd mudflow

for apkToAnalyze in ${dirToAnalyze}/*.apk ; do

	outputFileName="../output/mudflow/goodware/$(basename "${apkToAnalyze}" .apk)_results.xml"

	echo "Analyzing ${apkToAnalyze}"
	timeout 300 java -Xmx8g -cp "libs/*" soot.jimple.infoflow.android.TestApps.Test ${apkToAnalyze} ${androidPlatforms} > Logging.log 2>&1
	
	if [ ! -f ${outputFileName} ] ; then
		echo "Analysis of ${apkToAnalyze} timed out!"
	else
		echo "Finished analyzing ${apkToAnalyze}"
	fi

done

cd ${originalDir}
