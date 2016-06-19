#
# Getting and Cleaning Data
# Week 4 Assignment
#

#
# Download data file from the link provided
#
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 'myDataFile.zip')
unzip('myDataFile.zip')

#
# Read Column names from features.txt
#
myColNames <- read.table("UCI HAR Dataset/features.txt", 
                         header = FALSE,
                         sep = " ")

myActivityLabel <- read.table("UCI HAR Dataset/activity_labels.txt", 
                              header = FALSE, 
                              sep = " ", 
                              na.strings = "NA", 
                              quote = "")


#
# Read Train Data Set
# Read Train Activity Data Set
# Read Train Subject Data Set
# Set column names
# Combine the data sets
#
myTrainDataSet <- read.table("UCI HAR Dataset/train/X_train.txt", 
                             header = FALSE, 
                             sep = "", 
                             na.strings = "NA", 
                             quote = "")

myTrainActivity <-  read.table("UCI HAR Dataset/train/y_train.txt", 
                               header = FALSE, 
                               sep = "", 
                               na.strings = "NA", 
                               col.names = c("Activity"),
                               quote = "")

myTrainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt", 
                             header = FALSE, 
                             sep = "", 
                             na.strings = "NA", 
                             col.names = c("Subject"),
                             quote = "")

colnames(myTrainDataSet) <- as.character(myColNames$V2)
myTrainDataSet <- cbind(myTrainDataSet, myTrainActivity)
myTrainDataSet <- cbind(myTrainDataSet, myTrainSubject)

#
# Read Test Data Set
# Read Test Activity Data Set
# Read Test Subject Data Set
# Set column names
# Combine data sets
#
myTestDataSet <- read.table("UCI HAR Dataset/test/X_test.txt", 
                             header = FALSE, 
                             sep = "", 
                             na.strings = "NA", 
                             quote = "")


myTestActivity <-  read.table("UCI HAR Dataset/test/y_test.txt", 
                               header = FALSE, 
                               sep = "", 
                               na.strings = "NA", 
                               col.names = c("Activity"),
                               quote = "")

myTestSubject <- read.table("UCI HAR Dataset/test/subject_test.txt", 
                             header = FALSE, 
                             sep = "", 
                             na.strings = "NA", 
                             col.names = c("Subject"),
                             quote = "")

colnames(myTestDataSet) <- as.character(myColNames$V2)
myTestDataSet <- cbind(myTestDataSet, myTestActivity)
myTestDataSet <- cbind(myTestDataSet, myTestSubject)


#
# 1. Merges the training and the test sets to create one data set.
#
myMergeDataSet <- rbind(x = myTrainDataSet, y = myTestDataSet)

#
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
#
myMergeDataSet <- myMergeDataSet[, grep("(mean|std|Activity|Subject)", names(myMergeDataSet))]


# 
# 3. Uses descriptive activity names to name the activities in the data set
#
for ( i in 1:nrow(myActivityLabel) )
  myMergeDataSet$Activity[ which(myMergeDataSet$Activity == i) ] <- as.character(myActivityLabel$V2[i])


#
# 4. Appropriately labels the data set with descriptive variable names.
#

#
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
# for each activity and each subject.
#
myMergeDataSet2 <- aggregate(myMergeDataSet, by = list(myMergeDataSet$Activity, myMergeDataSet$Subject), FUN = "mean")
names(myMergeDataSet2)[(names(myMergeDataSet2) == "Group.1")] <- "Group.Activity"
names(myMergeDataSet2)[(names(myMergeDataSet2) == "Group.2")] <- "Group.Subject"


#
# write tidy data set to a text file
#
write.table(myMergeDataSet2, file = "myMergeDataSet2.txt", row.names = FALSE)
