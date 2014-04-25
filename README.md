##GetCleanDataProject
===================

###Peer assignment for "Getting and Cleaning Data"
Author: Guillermo J. Corominas Megias. 

###Description

This project generates a tidy dataset from the one located in 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip in order to be used for further analysis. 

###Files

    * README.md. This file 
    * run_analysis.R. This script does all the work. 
    * CodeBook.md. Explains the naming conventions for the variables. 

###Scripts:

####run_analysis.R. 

#####1. Requirements: 

    1.1 The previously specified dataset must be unzipped and placed in a folder   called "UCI HAR Dataset" in the same directory as the script. 
    1.2 Required files (all contained in the "UCI HAR Dataset" directory:
        -features.txt
        -activity_labels.txt
        -./test/subject_test.txt
        -./test/X_test.txt
        -./test/y_test.txt
        -./train/subject_train.txt
        -./train/X_train.txt
        -./train/y_train.txt

####2. Scripts task: 

    The script will take the data included in the aforementioned files, will aggregate them into only one object and then it will dump it into a single file. The steps required to perform this task are: 
    -Read the feature names from disk
    -Read X_test.txt, y_test.txt and subject_test.txt and combine them by columns into a single object. 
    -Read Y_train.txt, y_test.txt and subject_train.txt and combine them by columns into a single object. 
    -Merge both datasets into a single one. 
    -Create a new dataset with only the features that contain averages or standard deviations of actual measures, the activity column and the subject column.
    -Transform feature names to ones that are more readable and that contain no special characters like parentheses. 
    -Aggregate the data by subject and activity and compute means and standard deviations for each feature for each pair of (subject, activity)
    -Add a column of activity labels in order to make the activities easily readable in the final dataset. 
    -Reorder the columns placing subject and activity labels before the feature columns. 
    -Write the final dataset to disk. 
 
####3. Output files: 

    The script will dump the dataset into a file named "tidyDataset.txt" in the running directory. 


