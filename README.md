# DroidSLAM
A Study of Learning and Analysis of Malware for Android.  This project examines existing techniques for Android malware classification that 1) are learning-based, and 2) use only statically-derived features to perform classification.

This repository contains everything necessary to reproduce the results of our reproduction/comparison study.

## Prerequisites
To reproduce this project's results, you must have access to the [Drebin dataset](https://www.sec.cs.tu-bs.de/~danarp/drebin/) as well as [Androzoo](https://androzoo.uni.lu/).  See the respective websites for instructions on how to request access.

## Obtaining Drebin and Mudflow
To obtain all the tools required for this study, run getAllTools.sh from the project root directory.  This will clone the source for each tool and perform any required setup. 

## Downloading the necessary datasets
Run the datasetSetup.sh script from the project root directory, which will automatically download and extract the Drebin dataset as well as our Androzoo subset.

**IMPORTANT:** Running this script will result in the download of ~300GB of Android APK files and may take *several* hours.

## Partitioning the datasets
For reproducing our experiments, a set of 5 different partitions has been provided in the partitions directory.  Each partition has a 70/30 split between training and testing data.  If you would like to create your own partitions, see the partition.sh script.

## Running the experiments
TODO

## Outputing results
TODO
