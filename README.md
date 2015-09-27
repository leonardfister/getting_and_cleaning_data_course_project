# README.md for run_analysis.R and HAR_averages.txt 

## version details last modified
last modified 25 Sept 2015, author Leonard Fister

run_analysis.R needs programming language R (created and tested with R version 3.1.2 (2014-10-31)) and the R-package plyr (available on CRAN, created with R version 3.1.2.)

## codebook and further information 
A detailed description of the processing procedure and the variables can be found in CodeBook.md in the same directory as this README.md file. This codebook completes the original codebook (features_info.txt, README.txt) provided in the raw data directory. The additional information is detached and not added to the original codebook in order not to change any of the original source-files and thus maintain straightforward reproducability, also in terms of downloading of files.

Technical details on functionality of the script is given as comments in the script run_analysis.R itself.

## general purpose of project 
The raw data (directory "UCI\ HAR\ Dataset", from
unzipping
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip,
accessed 19 Sept 2015) of a human activity recognition (HAR) sensor in a
smartphone is processes to get the averages of the measurements related to means
and standard deviations of the sensor signals.

The raw sample consists of measurements for 30 people of 6 different types of
movement. The raw data directory ("UCI\ HAR\ Dataset") contains the files

- README.txt - activity_labels.txt : identifiers in the data (y_test.txt,
y_train.txt) for the different types of movement - features_info.txt : detailed
description of the features measured and analysed (X_test.txt, X_train.txt) -
features.txt : list of features in the order as measured in X_test.txt and
X_train.txt - subdirectory train/ : 70% of the data of the full data sample -
subdirectory test/ : 30% of the data of the full data sample

For detailed description of the sample and features of the measured raw data see
features_info.txt and README.txt in the data directory "UCI\ HAR\ Dataset".

## input / output

- input: 
    - raw data: directory "UCI\ HAR\ Dataset" ( ~283MB, from unpacking
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip,
accessed 19 Sept 2015) 
    - R-script for processing of raw data: run_analysis.R 
- output 
    - processed data: HAR_averages.txt (averages for the measurements for
means and standard deviations in raw data)

## usage Run the R script run_analysis.R to produce the processes data-file
HAR_averages.txt from the raw data from
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
(accessed 19 Sept 2015, zip contains folder "UCI\ HAR\ Dataset")

process data by

1. preparation: - download and unpack
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
-> unzipping outputs a directory "UCI\ HAR\ Dataset" (note large size ~283MB) -
put data-processing script (and corresponding README.md and CodeBook.md) in the
same directory as the "UCI\ HAR\ Dataset"

2. in programming language R: - set working directory (R-command
```setwd("<path>")```) to the directory where the data directory and
run_analysis.R are contained - run script run_analysis.R (R-command
```source("./run_analysis.R")```), script takes data from the directory (and
subdirectories of) "UCI\ HAR\ Dataset" note that imports/exports of large data
sets are slow and runtime is of the order of 5 minutes - tidy data is
(automatically) written to file "HAR_averages.txt"

3. for further analysis: import processed data in R with the command \ ``` 
test_import <- read.table("HAR_averages.txt",header= TRUE, check.names=FALSE) 
```