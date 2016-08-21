#John Hopkins Data Science Specialization - Getting and Cleaning Data - Project Codebook

##Project Description

This project is a class project for the Getting and Cleaning Data Coursera course from the Johns Hopkins Bloomberg School of Public Health.  The objective of the project is transform data from the UCI Machine Learning Repository into a 'tidy' data set with an average of each variable for each activity and each subject.

This codebook indicates the variables, the data, and all transformations, summaries, along with units, and work that I performed to clean up the data.  It also includes other relevant information such as the source of the original data.

##Study design and data processing

###Collection of the raw data

This code utilizes the Human Activity Recognition Using Smartphones Dataset from UCI Machine Learning Respository available at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#

The data used are from experiments carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

###Notes on the original (raw) data
For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The (original) dataset includes the following files:
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

Notes on original data: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws


##Source of Data:
Jorge L. Reyes-Ortiz(1,2), Davide Anguita(1), Alessandro Ghio(1), Luca Oneto(1) and Xavier Parra(2)
1 - Smartlab - Non-Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova, Genoa (I-16145), Italy. 
2 - CETpD - Technical Research Centre for Dependency Care and Autonomous Living
Universitat Politècnica de Catalunya (BarcelonaTech). Vilanova i la Geltrú (08800), Spain
activityrecognition '@' smartlab.ws

##Data Citation: 
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.

---

##Creating the tidy data set using run_analysis.R

To create the tidy data file from the UCI HAR dataset:

* Download the UCI HAR data from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
* Set R's working directory to the UCI HAR data file location
* Download run_analysis.R from https://github.com/HelpfulMe/GetCleanDataProject
* In R, source the run_analysis code to run run_analysis (you can use 'source("run_analysis.R")')
* Code will create a tidy dataset titled "mytidydata.txt" in the user's working directory


##Cleaning of the data

The following describes how the run_analysis.R code cleans and tidies the data from the UCI HAR dataset: (descriptive notes are also included in the code)

* Read 'test' data from the x_test.txt, y_test.txt, and subject_text.txt files into X_test, Y_test, and subj_test variables respectively.
* Read 'train' data from the x_train.txt, y_train.txt, and subject_train.txt files into X_train, Y_train and subj_train variables respectively.
* Use rbind to combine the x_test and x_train variables, repeating for the y_test and y_train variables, and the subj_test and subj_train variables (X, Y, and subj data frames created, each with 10299 observations)
* Use cbind to combine the X, Y, and subj dataframes into one dataframe, 'data'
* Rename two of the three 'v1' columns with more meaningful names 'subj' and 'activity'
* Use dplyr package to create dataframe table data_df
* Use dplyr's 'select' feature to select only the variables containing 'mean' or 'str', save as data2
* Create activitylabels dataframe containing descriptive activity labels ('walking', 'standing', etc instead of '1', '2', etc)
* Merge descriptive activity labels with data2 dataframe using 'merge', matching each activity description with the correlating id in the data2 dataframe
* Remove the now superlative 'activity' column from the resulting dataframe (contains id numbers for activities, not descriptive activity names)
* Load descriptive variables names from the 'features.txt' file
* Create a features dataframe
* Select only the 'features' containing 'mean' or 'str'
* Make the 'features' tidy by removing extra punctuation, spaces, and capital letters
* Add the 'subj' and 'activitydesc' variables to the features list so can merge it with data2 
* Rename the columns of data2 with the descriptive column names in 'features' list
* Use the reshape2 package to melt the data2 dataset with the 'subj' and 'activitydesc' variables as IDs
* Re-cast the data in wide form using dcast, providing the mean of each subject/ activity pair, saving result as data_tidy dataframe
* Use write_table to write the tidy dataset 'data_tidy' to the user's working directory as "mytidydata.txt"


##Description of the variables in the mytidydata.txt file

###Dimensions: 
180 observations of 88 variables

###Summary of the data: 
The mean of each variable is calculated for each subject-activitydesc pairing.  There are 30 subjects with 6 activities each for a total of 180 subject-activity pairings.  Only variables including 'mean' or 'std' are included in the tidy data.

###Variables: (with data type)

* subj - integer
* activitydesc - character
* tbodyaccmeanx - numerical
* tbodyaccmeany - numerical
* tbodyaccmeanz - numerical
* tbodyaccstdx - numerical  
* tbodyaccstdy - numerical 
* tbodyaccstdz - numerical
* tgravityaccmeanx - numerical
* tgravityaccmeany - numerical
* tgravityaccmeanz - numerical  
* tgravityaccstdx - numerical  
* tgravityaccstdy - numerical
* tgravityaccstdz - numerical
* tbodyaccjerkmeanx - numerical
* tbodyaccjerkmeany - numerical
* tbodyaccjerkmeanz - numerical
* tbodyaccjerkstdx - numerical  
* tbodyaccjerkstdy - numerical 
* tbodyaccjerkstdz - numerical  
* tbodygyromeanx - numerical   
* tbodygyromeany - numerical 
* tbodygyromeanz - numerical 
* tbodygyrostdx - numerical 
* tbodygyrostdy - numerical 
* tbodygyrostdz - numerical  
* tbodygyrojerkmeanx - numerical
* tbodygyrojerkmeany - numerical
* tbodygyrojerkmeanz - numerical   
* tbodygyrojerkstdx - numerical 
* tbodygyrojerkstdy - numerical
* tbodygyrojerkstdz - numerical 
* tbodyaccmagmean - numerical  
* tbodyaccmagstd - numerical 
* tgravityaccmagmean - numerical 
* tgravityaccmagstd - numerical
* tbodyaccjerkmagmean - numerical  
* tbodyaccjerkmagstd - numerical 
* tbodygyromagmean - numerical 
* tbodygyromagstd - numerical 
* tbodygyrojerkmagmean - numerical 
* tbodygyrojerkmagstd - numerical 
* fbodyaccmeanx - numerical
* fbodyaccmeany - numerical 
* fbodyaccmeanz - numerical
* fbodyaccstdx - numerical
* fbodyaccstdy - numerical
* fbodyaccstdz - numerical
* fbodyaccmeanfreqx - numerical
* fbodyaccmeanfreqy - numerical
* fbodyaccmeanfreqz - numerical 
* fbodyaccjerkmeanx - numerical 
* fbodyaccjerkmeany - numerical
* fbodyaccjerkmeanz - numerical
* fbodyaccjerkstdx - numerical
* fbodyaccjerkstdy - numerical 
* fbodyaccjerkstdz - numerical
* fbodyaccjerkmeanfreqx - numerical
* fbodyaccjerkmeanfreqy - numerical
* fbodyaccjerkmeanfreqz - numerical
* fbodygyromeanx - numerical
* fbodygyromeany - numerical
* fbodygyromeanz - numerical
* fbodygyrostdx - numerical 
* fbodygyrostdy - numerical  
* fbodygyrostdz - numerical
* fbodygyromeanfreqx - numerical
* fbodygyromeanfreqy - numerical 
* fbodygyromeanfreqz - numerical 
* fbodyaccmagmean - numerical
* fbodyaccmagstd - numerical  
* fbodyaccmagmeanfreq - numerical
* fbodybodyaccjerkmagmean - numerical 
* fbodybodyaccjerkmagstd - numerical 
* fbodybodyaccjerkmagmeanfreq - numerical 
* fbodybodygyromagmean - numerical
* fbodybodygyromagstd - numerical
* fbodybodygyromagmeanfreq - numerical 
* fbodybodygyrojerkmagmean - numerical 
* fbodybodygyrojerkmagstd - numerical
* fbodybodygyrojerkmagmeanfreq - numerical 
* angletbodyaccmeangravity - numerical 
* angletbodyaccjerkmeangravitymean - numerical
* angletbodygyromeangravitymean - numerical 
* angletbodygyrojerkmeangravitymean - numerical
* anglexgravitymean - numerical 
* angleygravitymean - numerical 
 
---
##Sources

Assistance with codebook from codebook template from https://gist.github.com/JorisSchut/dbc1fc0402f28cad9b41