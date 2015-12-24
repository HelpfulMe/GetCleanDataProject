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

## test data
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

# Use rbind to make one column for subjects
subj <- rbind(subj_test, subj_train)

# repeat for X (test variables)
X <- rbind(X_test, X_train)

# and repeat again for Y (activity labels)
Y <- rbind(Y_test, Y_train)

# we have three groups, subj, X, and Y, all with 10299 observations
# I will use cbind to combine them into one data set called 'data' to 
# complete step 1.
data <- cbind(subj, X, Y)


## ============================================================================
## Assignment Part 2: 
## # 2.	Extracts only the measurements on the mean and standard deviation for 
#           each measurement. 

## currently my "data" is in the dangerous state of having three columns with
# identical names: V1.  To avoid problems in the next step, I'll rename
# two of the columns so each has a unique name

# rename subject column, the first column in the data: 
names(data)[1] <- "subj"

# and rename activity column, the last column in the data:
names(data)[563] <- "activity"

## I will use the dplyr library to manipulate the data:
# load dplyr library
library("dplyr")

# set up data as a data frame table so can manipulate with dplyr
data_df <- tbl_df(data)

## In case I want to use tidyr:
# load tidyr library
# library("tidyr")