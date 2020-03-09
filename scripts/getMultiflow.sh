#!/bin/bash

# Retrieves multiflow from git and gets necessary scripts from
# the BlueSeal website

cd ..

if [[ -d multiflow ]] ; then
	echo "Multiflow directory already exists... no need to clone repo"
else
	git clone https://github.com/ub-rms/multiflow.git
fi

cd multiflow || { printf "cd failed (multiflow may not have downloaded successfully), exiting\n" >&2;  return 1; }

if [[ -d n-gram ]] ; then
	echo "Multiflow scripts already obtained"
else
	curl -O http://blueseal.cse.buffalo.edu/files/scripts.tar.gz && tar xvzf scripts.tar.gz
fi
