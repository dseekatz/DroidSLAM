#!/bin/bash

# Running the required mudflow analysis before applying the classifier
# Parallelized so it can finish within 24 hours
# Ideally, the timeout would be more like 300 seconds rather than 60, but I don't have that kind of time

# This should be provided as an argument and not hardcoded maybe?
androidPlatforms="$ANDROID_HOME/platforms"

dirToAnalyze=$(realpath -s $1)
originalDir=$(pwd)

cd mudflow

mkdir -p logging

# An attempt at an explanation:
# 1) Find all .apk files in the directory to analyze
# 	2) Pipe that to xargs to run 50 parallel commands of the following template
#	3) run the following command in a new subshell (necessary b/c of how xargs handles input from the find command, I think)
#		4) time out the following command if doesn't finish within 60 seconds
#		5) run mudflow, with .apk file {} (taken from find command passed through xargs) and platform directory ${1} (see (8))
#		6) redirect the output to a logging file
#		7) write the executed command to stdout, so that I can make sure things are working properly
#	8) pass arguments to the subshell.  "sh" is a dummy argument used to preserve the convention of $0=scriptName, $1=VAR1, etc...
find ${dirToAnalyze} -name '*.apk' | \
	xargs -n 1 -I{} -P 100 \
	sh -c \
	'echo "{}"
	if [ ! -f ../output/mudflow/${2}/$(basename {} .apk)_results.xml ] ; then
		timeout 60 \
		java -Xmx8g -cp "libs/*" soot.jimple.infoflow.android.TestApps.Test {} ${1} --saveresults ../output/mudflow/${2} \
		> logging/$(basename {}).log 2>& 1 \
		&& echo "Finished analyzing {}"
	else
		echo "Already analyzed {}"
	fi' \
	"sh" "${androidPlatforms}" "$(basename ${dirToAnalyze})"

cd ${originalDir}
