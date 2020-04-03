#!/bin/bash

# Running the required mudflow analysis before applying the classifier
# For now, just a playground to figure out how this stuff works

# This should be provided as an argument and not hardcoded?
androidPlatforms="$ANDROID_HOME/platforms"

dirToAnalyze=$(realpath -s $1)
#apkToAnalyze=$(realpath -s $1)
originalDir=$(pwd)

cd mudflow

for apkToAnalyze in ${dirToAnalyze}/*.apk ; do

	echo "Analyzing ${apkToAnalyze}"
	java -Xmx8g -cp "libs/*" soot.jimple.infoflow.android.TestApps.Test ${apkToAnalyze} ${androidPlatforms} --timeout 300 > Logging.log 2>&1
	echo "Finished analyzing ${apkToAnalyze}"

done

cd ${originalDir}
