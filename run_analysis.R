# version 1, 26 Sept 2015, author Leonard Fister
#
# comments:
#
# detailed information can be found in README.md and CodeBook.md.
#
# This file processes the raw data from UCI\ HAR\ Dataset.
# The training and test sets are combined with their subject 
# identifiers and their activities and then merged to one 
# large data set. The column names of the feature measurements
# are taken from features.txt. Those columns matching the pattern
# mean() or std() are kept only.
# The averages over the different features for each subject and
# each activity are computed.
# The resulting data set is written to HAR_averages.txt.
# Note that the column names in the output file are identical to 
# the original ones, even though they now relate to averaged 
# quantities.
#
# The processed data can be imported into R by the command
#     read.table(<path of HAR_averages.txt>,header= TRUE, check.names=FALSE)
#
##############################################
# script: execute in R with command 
#   setwd(<path to directory with run_analysis.R and UCI\ HAR\ Dataset>)
#   source("run_analysis.R")

print("begin of script")

# setting working directory 
#    script stops if run_analysis.R not in the present working directory
#    set externally or on a fixed given machine by uncommenting this line and setting the path
#    setwd("~/github/getting_and_cleaning_data_course_project/")
if( !any("run_analysis.R"==dir()) ){
    print("problem with (settig of) working directory")
    stop()
}

# setting raw data directory
#    downloaded (19 Sept 2015) and unzipped from 
#    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
dir <- "UCI HAR Dataset/"
if(file.exists(dir)){
        print("data directory set correctly")
    }else{
        stop("problem with setting data directory")
    }

# imports of 
#   activity_labels (act_labels, column names activityID, activity)
#   features (feat_vec, column names featuresID, feature) and
#   feature measurements (X_test/X_train, column names from feat_vec$feature) with
#   subject identifiers (s_test/s_train, column name subjectID) and
#   activity identifiers (y_test/y_train, column name activity)
#   note: check.names=FALSE in order not to abbreviate expressions 
print("importing files ...")
temporary.olddir <- getwd()
setwd(dir)
act_labels <- read.table("activity_labels.txt"    ,col.names=c("activityID","activity"))
feat_vec   <- read.table("features.txt"           ,col.names=c("featuresID","feature"))
X_test     <- read.table("test/X_test.txt"        ,col.names=feat_vec$feature, check.names=F)
s_test     <- read.table("test/subject_test.txt"  ,col.names="subjectID")
y_test     <- read.table("test/y_test.txt"        ,col.names="activity")
X_train    <- read.table("train/X_train.txt"      ,col.names=feat_vec$feature, check.names=F)
s_train    <- read.table("train/subject_train.txt",col.names="subjectID")
y_train    <- read.table("train/y_train.txt"      ,col.names="activity")
setwd(temporary.olddir)
rm(temporary.olddir)
print("imports done")

# merge (s_test,y_test,X_test) and (s_train,y_train,X_train)
#   then merge to one table
#   (bind test and training data-set with activity and subjectID by columns)
#   (bind training and test data-sets by rows)
#   merge to data frame "ha" (_h_uman _a_ctivity)
train <- cbind(s_train,y_train,X_train) # merge measurements with activity and subjectID
test  <- cbind(s_test,y_test,X_test)    # merge measurements with activity and subjectID
ha <- rbind(test,train)                 # merge training and test sets [cf. 1. in proj. description]
print("data merged to one data set")

# sort in ascending order with respect to subjectID, with plyr-package and arrange()
#   [personal preference, not asked for in assignement]
library(plyr)
ha <- arrange(ha,subjectID)

# select mean and standard deviation features only:
#   ha_ms (_h_uman _a_ctivity _m_ean _s_tandard deviation)
#   grep("mean\\(\\)*|std\\(\\)*",features)
#      -> 66 features that contain the parts "mean()" or "std()"
#   note that columns 1, 2 contain subjectID and activity, not matching the pattern 
#      -> they are kept by hand: c( 1, 2, grep("mean\\(\\)*|std\\(\\)*",names(ha)))
#   select only the columns that match this pattern:
ha_ms <- ha[, c(1,2,grep("mean\\(\\)*|std\\(\\)*",names(ha)))] # [cf. 2. in project description]
print("features matching mean() or std() selected")

# Uses descriptive activity names to name the activities in the data set
#   take names from act_labels read from activity_labels.txt
ha_ms$"activity" <- 
    factor(ha_ms$"activity" , 
           levels=act_labels$"activityID", 
           labels=act_labels$"activity") # [cf. 3 in project description]
print("activity labels set")

#column averages for individual subjects and activity
ha_ms_mean <- 
    aggregate(ha_ms[-(1:2)],
              by=list("subjectID"=ha_ms$"subjectID","activity"=ha_ms$"activity"),
              mean)
print("column averages for each subject and activity computed")

#write processed data
out.file <- "HAR_averages.txt"
print(paste("writing data to",out.file))
write.table(ha_ms_mean,out.file)
print("export done")
#further use with
#test_import <- read.table("HAR_averages.txt",header= TRUE, check.names=FALSE)

print("end of script")
##############################################
