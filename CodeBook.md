#CodeBook for run_analysis.R, HAR_averages.txt

##version details
last modified 25 Sept 2015, author Leonard Fister

run_analysis.R needs programming language R (created and tested with R version 3.1.2 (2014-10-31)) and the R-package plyr (available on CRAN, created with R version 3.1.2.)

##purpose of processing 
This file contains information about the data processing procedure and the definition of variables. Note that this file completes the file "README.md" (see below) for usage about execution of the script and the code book of the raw data ("features_info.txt" and "README.txt" in raw data directory "UCI HAR Dataset"). The additional information is detached and not added to the original codebook in order not to change any of the original source-files and thus maintain straightforward reproducability, also in terms of downloading of files. For completeness, the content of the files are copied to the end of this file, see sections "./UCI\ HAR\ Dataset/features_info.txt" and "./UCI\ HAR\ Dataset/README.txt".

##README.md and further information
Details for the usage can be found in the file README.md in the same directory as this file CodeBook.md. 

##input: 
The raw data for the Human Activity Recognition sensors is located in the directory "UCI\ HAR\ Dataset", downloaded and unzipped from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip,
accessed 19 Sept 2015: measurements of motion sensor in smartphones for 6 different types of movements for a training set and test set (split in 70%:30% ratio) for in total 30 persons. 

input files (in directory ./UCI\ HAR\ Dataset/) used in the cleaning and processing

- activity_labels.txt : identifiers for 6 different types of activities
- features.txt : measured features in the order as their measurements are stored in the files "./UCI\ HAR\ Dataset/test/X_test.txt" and "./UCI\ HAR\ Dataset/train/X_train.txt".
- train/X_train.txt (test/X_test.txt) : measurements of the different features for the training (test) set for different activities and persons (see below).
- train/subject_train.txt (test/subject_test.txt) : identifiers for the subjects related to the measurements in the data given in train/X_train.txt (test/X_test.txt).
- train/subject_train.txt (test/subject_test.txt) : identifiers for the activities for related to the measurements in the data given in train/X_train.txt (test/X_test.txt).

Note that the subdirectories test/Inertial\ Signals/ and train/Inertial\ Signals/ are not used.

##processing 

1. Import of files activity_labels.txt, features.txt, train/X_train.txt, train/y_train, train/subject_train.txt, test/X_test.txt, test/y_test and test/subject_test.txt.
2. Columns of the feature measurements are named by the features given in features.txt.
3. The subject identifiers, activity labels and feature measurements are merged (first into separate datasets for the training and test sets individually, then) into one dataset comprising both training and test sets: first column is the subject identifier (column name "subjectID"), second column is the activity identifier (column name "activity", to be replaced with descriptive names, see below), the remaining columns store the columns from the feature measurements. 
4. The data set is ordered with respect to subject identifier "subjectID" (with function ```arrange()``` from the plyr-package).
5. Only the features relating to the means and standard deviations are kept: the pattern matching is done with respect to the column name containing either "mean()" of "std()" (i.e. columns with for individual directions as indicated by a suffix, e.g. "-X", are kept as well).
6. The activity identifiers are replaced with the descriptive names (as factors) as given in the file activity_labels.txt.
7. For each subject and for each activity, the mean of the separate features is computed and stored into the processed data set to be written out. Note that the column names are maintained, but the data stored are now the averages of the different measurements per variable in the raw data.
8. The processed data set is written to the file HAR_averages.txt

##description of HAR_averages.txt
The first column contains the identifier of the test subject.

The second column contains the activity label.

The further columns contain the means of the feature measurements for the features whose names contain either the pattern "mean()" or "std()", i.e. relating to means and standard deviations of the measurements. For description of the features see file features_info.txt (in raw data directory "./UCI\ HAR\ Dataset/", also copied below in the section ./UCI\ HAR\ Dataset/features_info.txt).

##for further use
The processed data can be imported in R with the command ```test_import <- read.table("HAR_averages.txt",header= TRUE, check.names=FALSE)```

##technical details
technical details about the script can be found as comments in the script run_analysis.R

## ./UCI\ HAR\ Dataset/README.txt
copy of the file accessed on 19 Sept 2015
```
==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universit‡ degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
```


## ./UCI\ HAR\ Dataset/features_info.txt 
copy of the file accessed on 19 Sept 2015
```
Feature Selection 
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'
```

