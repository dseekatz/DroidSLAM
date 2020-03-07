#!/bin/bash

# This script performs the main setup process for replicating our experiments
# by downloading and organizing the required malware and goodware APKs
#
# !!!!!!!!! WARNING !!!!!!!!!
# Running this script will download ~300GB of Android APKs
# and may take hours or possibly days to finish!
# !!!!!!!!! WARNING !!!!!!!!!

# First, get the DREBIN malware dataset
echo "Attempting to download DREBIN dataset"
./malwareScripts/getDrebinDataset.sh ./malware

# Next, get the benign APKs from Androzoo
echo "Attempting to retieve benign APKs from Androzoo"
./goodwareScripts/getBenignAPKs.sh ./goodware

# Finally, remove duplicates from the benign dataset
echo "Removing Duplicate APKs from the benign dataset"
./goodwareScripts/removeDuplicates.sh ./goodware
