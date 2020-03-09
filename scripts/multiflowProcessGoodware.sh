#!/bin/bash

# Run the multiflow APK fragment extractor on all of the goodware
# Takes a long time to run

originalDir=$(pwd)

cd ../multiflow

if [[ -f goodware.log ]] ; then
	rm goodware.log
fi

for apk in ../goodware/*.apk
do
	java -jar multiflowAPI.jar "${apk}" >>goodware.log 2>&1
done

cd "${originalDir}"
