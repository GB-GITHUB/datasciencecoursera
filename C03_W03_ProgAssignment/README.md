run_analysis.R
==============

Getting and Cleaning Data Course Project

This is a repository for the course project of the online course Getting and Cleaning Data from Coursera.

You can find information about the data in CodeBook.md.

The R code is for creating a new tidy data set with the average of each variable for each activity and each subject from the raw data.

After downloading the data from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Extract it into the data directory under your R working directory.

You can run R code run_analysis.R or source it. It will generate a text file named "tidyData.txt". This is the required data set.

Library dependencies:
- reshape2

The code performs the following operations:
- Open the different datasets (all the train and test datasets + features, subject and activity labels)
- Extracts only the measurements on the mean and standard deviation for each measurement i.e. the variables containing "mean()" or "std()"
- Uses descriptive activity names to name the activities in the data set
- Creates a second, independent tidy data set with the average of each variable for each activity and each subject.