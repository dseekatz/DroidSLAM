#!/bin/bash

# Remove "duplicate" Androzoo apk files from a given directory.
# Androzoo doesn't actually provide any true duplicates, as every
# APK file included in the dataset has a unique hash.  However, we
# assume that all benign apks that share a package name are variations
# of the same application.  We therefore remove all but one apk
# for each package name.

directory=$1
regex=".*[A-Fa-f0-9]{40}.apk"
	
# find any apks that match the regex
# and remove them.
find ${directory} -regextype posix-extended -regex ${regex} -delete -print
