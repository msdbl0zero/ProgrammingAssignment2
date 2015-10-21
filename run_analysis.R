# Author: Mary Li

# Dataset: reference to following publication:
# Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition
# on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient
# Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
# This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors
# or their institutions for its use or misuse. Any commercial use is prohibited.
# Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

setwd("/Users/Dbl0Zero/Documents/Personal/Learning/GetAndCleanData/Homework/")
library(dplyr)
# run_analysis.R that does the following. 

# Merges the training and the test sets to create one data set.
Dir <- "/Users/Dbl0Zero/Documents/Personal/Learning/GetAndCleanData/Homework//UCI HAR Dataset/"
trainDir <- paste(Dir, "train/", sep="")
testDir <- paste(Dir, "test/", sep="")
mergedDir <- paste(Dir,"merged/", sep="")

X_train <- read.table(paste(trainDir, "X_train.txt", sep=""))
X_test <- read.table(paste(testDir, "X_test.txt", sep=""))
X_merged <- rbind(X_train,X_test)


y_train <- read.table(paste(trainDir, "y_train.txt", sep=""))
y_test <- read.table(paste(testDir, "y_test.txt", sep=""))
y_merged <- rbind(y_train,y_test)

data <- cbind(X_merged)
rm(X_train, y_train, X_test, y_test)

# Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.table(paste(Dir,"features.txt", sep=""))

library(regexr)
meansInd <- grepl("mean\\(\\)",colnames(data),ignore.case = FALSE, perl = FALSE)
stdInd <- grepl("std\\(\\)",colnames(data),ignore.case = FALSE, perl = FALSE)
selectedFeatures <- subset(data, select=c(which(meansInd,TRUE), which(stdInd,TRUE)) )

# Appropriately labels the data set with descriptive variable names. 
f <- as.character((as.list(features))$V2)
colnames(data) <- f

# Uses descriptive activity names to name the activities in the data set
activityNames <- read.table(paste(Dir,"activity_labels.txt", sep=""))
activities <- inner_join(y_merged, activityNames, by=("V1"="V1"))
colnames(activities)= c("activityIndex", "activity")
data <- cbind(selectedFeatures,activities$activity)
names(data)[length(data)] <- "activityName"
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for
# each activity and each subject.
require(stats)
ds_splitByActivity <- group_by(data,activityName) 
clean_ds <- summarise_each(ds_splitByActivity,funs(mean))
write.table(clean_ds, paste(Dir, "clean_dataset.txt", sep=""), row.name=FALSE)

#output
clean_ds

