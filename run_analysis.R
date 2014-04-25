#
# Author: Guillermo J. Corominas Megias. 
# 
# run_analysis.R
#
# Cleans a specific dataset and prepares it to be easily manipulated. 
#


####################################
#   Read features from disk:
####################################
features <- read.table("./UCI HAR Dataset/features.txt", sep="")

####################################
#  Read the test set set from disk. 
####################################
testData <- read.table("./UCI HAR Dataset/test/X_test.txt", sep="")
names(testData) <- features[,c("V2")]

#Read the activity values for each row
testDatay <- read.table("./UCI HAR Dataset/test/y_test.txt", sep="")
names(testDatay) <- c("activity")

#Read the subjects that correspont to each row of measures. 
testDataSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt", sep="")
names(testDataSubject) <- c("subject")

#Combine all columns of data
testData <- cbind(testData, testDatay, testDataSubject)

####################################
#  Read the train set set from disk. 
####################################
trainData <- read.table("./UCI HAR Dataset/train/X_train.txt", sep="")
names(trainData) <- features[,c("V2")]

#Read the activity values for each row
trainDatay <- read.table("./UCI HAR Dataset/train/y_train.txt", sep="")
names(trainDatay) <- c("activity")

#Read the subjects that correspont to each row of measures. 
trainDataSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt", sep="")
names(trainDataSubject) <- c("subject")

#Combine all columns of data
trainData <- cbind(trainData, trainDatay, trainDataSubject)

#####################################
#      Merge both datasets: 
#####################################
newDataset <- rbind(testData, trainData)

#####################################
# Cleaning of features: 
#
# 1. Get the features that store:
#    -Means or standard deviations
#    -Activity
#    -Subject
# 2. Make feature names more readable
#
#####################################

#Subset the features. 
features <- read.table("./UCI HAR Dataset/features.txt", sep="")
subsetFeatures <- as.character(subset(features, grepl("mean[(][)]|std[(][)]", V2))[,c("V2")])
subsetFeatures <- c(subsetFeatures, c("activity", "subject")) 

#Get a new dataset with only the selected features
newDataset <- newDataset[, subsetFeatures]

#Make feature names more readable: 
subsetFeatures <- gsub("[()]", "", subsetFeatures)
subsetFeatures <- gsub("([A-Z])", "_\\1", subsetFeatures)
subsetFeatures <- gsub("-", "_", subsetFeatures)
subsetFeatures <- gsub("__", "_", subsetFeatures)
subsetFeatures <- tolower(subsetFeatures)


#Assign the new feature names to our dataset. 
names(newDataset) <- subsetFeatures

#################################################
#          Split and aggregate
#
#   1. Split the dataset by subject and activity
#   2. Apply the mean function across each column
#      of measures
#
############################################
reducedDataset <- t(sapply(split(newDataset,list(newDataset$subject,newDataset$activity)), colMeans))

##################################################
#   Make the activity column more readable
##################################################

#Read the activity codes and descriptions 
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
names(activityLabels) <- c("activity", "activity_description")

#Merge the datasets to obtain an activity description for each row
reducedDataset <- merge(reducedDataset, activityLabels, by.x="activity", by.y="activity", all = FALSE)

#Reorder the columns and place subject and activity at the begining.
col_idx <- grep("activity_description", names(reducedDataset))
reducedDataset <- reducedDataset[, c(col_idx, (1:ncol(reducedDataset))[-col_idx])]
col_idx <- grep("subject", names(reducedDataset))
reducedDataset <- reducedDataset[, c(col_idx, (1:ncol(reducedDataset))[-col_idx])]

####################################################
#       Write the obtained dataset to disk
####################################################
write.table(reducedDataset, file="./tidyDataset.txt", row.names=FALSE)