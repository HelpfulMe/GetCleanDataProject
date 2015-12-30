## ============================================================================

## Project Assignment Instructions:

# You should create one R script called run_analysis.R that does the following. 
# 1.	Merges the training and the test sets to create one data set.
# 2.	Extracts only the measurements on the mean and standard deviation for 
#           each measurement. 
# 3.	Uses descriptive activity names to name the activities in the data set
# 4.	Appropriately labels the data set with descriptive variable names. 
# 5.	From the data set in step 4, creates a second, independent tidy data set
#           with the average of each variable for each activity and each subject.

## ============================================================================

## My code

# Set options
options(stringsAsFactors = FALSE)


## load data
## Per assignment instructions, data is assumed to already be loaded in the 
## user's working directory: 
##      "The code should have a file run_analysis.R in the 
##      main directory that can be run as long as the Samsung data is in your 
##      working directory"

# get user's working directory: 
wd <- getwd()

## read test data
# X_test.txt
X_test <- read.table(file.path(wd, "test", "X_test.txt"))
# y_test.txt
Y_test <- read.table(file.path(wd, "test", "y_test.txt"))
# subject_test.txt
subj_test <- read.table(file.path(wd, "test", "subject_test.txt"))

## train data
# X_train.txt
X_train <- read.table(file.path(wd, "train", "X_train.txt"))
# y_test.txt
Y_train <- read.table(file.path(wd, "train", "y_train.txt"))
# subject_test.txt
subj_train <- read.table(file.path(wd, "train", "subject_train.txt"))

## ============================================================================
## Assignment Part 1: 
## # 1.	Merges the training and the test sets to create one data set.



# use rbind to make one column for X (test variables)
X <- rbind(X_test, X_train)

# repeat for Y (activity labels)
Y <- rbind(Y_test, Y_train)

# and repeat again for subjects
subj <- rbind(subj_test, subj_train)

# we have three groups, X, Y, and subj, all with 10299 observations
# I will use cbind to combine them into one data set called 'data' to 
# complete step 1.
data <- cbind(X, Y, subj)


## ============================================================================
## Assignment Part 2: 
## # 2.	Extracts only the measurements on the mean and standard deviation for 
#           each measurement. 

## currently my "data" is in the dangerous state of having three columns with
# identical names: V1.  To clarify things, I'll rename
# two of the columns so each has a unique name

# rename activity column, the 'y' column, the second-to-last column in the data:
names(data)[562] <- "activity"

# and rename subject column, the last column in the data: 
names(data)[563] <- "subj"

## I will use the dplyr library to manipulate the data:
# load dplyr library
library("dplyr")

# set up data as a data frame table so can manipulate with dplyr
data_df <- tbl_df(data)

# now use dplyr's 'select' option to select only the columns containing mean
# or standard deviation, as well as last two columns containing activity
# and subject information
## note: as directions do not specify whether to include only features ending
## in mean or std, or ones where the terms appear anywhere in the feature
## description, this code pulls all the columns where "mean" or "std" appear
## anywhere in the description

data2 <- select(data_df, 1:6, 41:46, 81:86, 121:126, 161:166, 201:202, 214:215, 
                227:228, 240:241, 253:254, 266:271, 294:296, 345:350, 373:375, 
                424:429, 452:454, 503:504, 513, 516:517, 526, 529:530, 539, 
                542:543, 552, 555:563)

## ============================================================================
## Assignment Part 3: 
## # 3.	Uses descriptive activity names to name the activities in the data set

# first I will make a data frame with activity labels
# note: to make the data cleaner, capital letters have been changed to lowercase, 
# and underscores removed

activitylabels <- data.frame(id=1:6, activitydesc=c("walking", "walkingupstairs", 
                             "walkingdownstairs", "sitting", "standing", 
                             "laying"))

# merge the activity labels with data2
data2 <- merge(data2, activitylabels, by.x = "activity", by.y = "id")

# i will now have two columns for activity: "activity" (id numbers) and 
# "activitydesc" which I will clean up by deleting the "activity"(id number) column
data2 <- select(data2, -(activity))

## ============================================================================
## Assignment Part 4:
## # 4.	Appropriately labels the data set with descriptive variable names. 

# First, I load all the variable names from features.txt using read.table
features <- read.table(file.path(wd, "features.txt"))

# set features up as a table dataframe so that can manipulate with dplyr
features <- tbl_df(features)

# then i select only the variables we are interested in 
features <- features[features$V1 %in% c(1:6, 41:46, 81:86, 121:126, 
                                              161:166, 201:202, 214:215, 
                                              227:228, 240:241, 253:254, 
                                              266:271, 294:296, 345:350, 373:375, 
                424:429, 452:454, 503:504, 513, 516:517, 526, 529:530, 539, 
                542:543, 552, 555:563), ]

# for a tidy dataset I do not want any capital letters
# I convert the features to all lowercase
features <- tolower(features$V2)

# I also don't wany any odd characters such as "(", ")", ", " or "-"
features <- gsub("\\(", "", features)
features <- gsub("\\)", "", features)
features <- gsub("\\,", "", features)
features <- gsub("\\-", "", features)


## In case I want to use tidyr:
# load tidyr library
# library("tidyr")