#!/bin/bash

if [[ -d drebin ]] ; then
	echo "Drebin directory already exists... no need to clone repo"
else
	git clone https://github.com/dseekatz/drebin.git
fi
