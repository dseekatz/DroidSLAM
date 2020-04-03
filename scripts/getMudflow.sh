#!/bin/bash

originalDir=$(pwd)

if [[ -d mudflow/mudflow-statistical-analysis ]] ; then
	echo "Mudflow directory already exists... no need to clone repo"
else
	mkdir mudflow && cd mudflow
	git clone https://github.com/dseekatz/mudflow-statistical-analysis.git
	cd originalDir
fi
