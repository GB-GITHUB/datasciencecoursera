# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#setwd("I:/MOOC/COURSERA/Johns Hopkins/The Data Science Specialization/03 - Getting and cleaning Data/Programming Assignments/DATA/train/")

X_train <- read.table("./X_train.txt", quote="\"")
features <- read.table("./features.txt", quote="\"")
X_test <- read.table("./X_test.txt", quote="\"")
activity_labels <- read.table("./activity_labels.txt", quote="\"")
activities_train <- read.table("./y_train.txt", quote="\"")
activities_test <- read.table("./y_test.txt", quote="\"")
subject_train <- read.table("./subject_train.txt", quote="\"")
subject_test <- read.table("./subject_test.txt", quote="\"")


# [STEP1] Merge dat sets into single one
# --------------------------------------
X_data <- rbind(X_train,X_test)
activities_data <- rbind(activities_train, activities_test)
subject_data <- rbind(subject_train, subject_test)

# Free memory from unecessary items
rm(X_train)
rm(X_test)
rm(activities_train)
rm(activities_test)
rm(subject_train)
rm(subject_test)


# [STEP4] Appropriately labels the data set with descriptive variable names
# --------------------------------------
names(X_data) <- features$V2

# [STEP 2] Extracts only the measurements on the mean and standard deviation for each measurement
# --------------------------------------

# From features_info.txt:
# "The set of variables that were estimated from these signals are: 
#       mean(): Mean value
#       std(): Standard deviation"

# Set which features must be kept 
# --> '(' and ')' are metacharacters in reg exp and found out on the web that
# in order to escape them I was needing a "double" escape, so the need and use of '\\'
features$toKeep <- grepl("mean\\()", features$V2) | grepl("std\\()", features$V2)

# Remove unecessary variables from dataset
X_data <- subset(X_data, select=features$toKeep)

# Free memory from unecessary items
rm(features)

# [STEP 3] Uses descriptive activity names to name the activities in the data set
# --------------------------------------------------------------------------------

# Add activity code info to main dataset
X_data <- cbind(subject_data, activities_data, X_data)

# Rename variable
names(X_data)[1] <- "subject.id"
names(X_data)[2] <- "activity.code"

# Add Activity labels to dataset using the merge command
X_data <- merge(X_data, activity_labels, by.x = "activity.code", by.y="V1", all=TRUE)
names(X_data)[69] <- "activity.label"

# [STEP 5] Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# --------------------------------------------------------------------------------
library(reshape2)

# Pivoting variable columns into rows (except for id cols)
X_data <- melt(X_data, id=c("activity.code","subject.id","activity.label"), measure.vars=colnames(X_data)[3:68])

# Cast mean function for each variable by subject by activity
tidy_data <- dcast(X_data, subject.id + activity.label ~ variable, mean)

# export result to file
write.table(tidy_data, file = "tidyData.txt")
