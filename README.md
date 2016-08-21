# Getting and Cleaning Data Course Project
This repository contains my Getting and Cleaning Data Course Project information for the Johns Hopkins Bloomberg School of Public Health course on Coursera.

# Contents
This repository contains: 
*README.md - a readme document containing details on what the script does and how to run it
*CodeBook.md - a CodeBook containing a description of the tidy data set, as well as deatils on how run_analysis creates the tidy data set. 
* run_analysis.R - R code creating a tidy data set from UCI-HAR
* mytidydata.txt - text file containing tidy data created by run_analysis.R and described in codebook.md

# To Use: 
* Download and unzip the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Set R's working directory to the UCI HAR data file location, or make sure to save the unzipped file in R's current working directory
* Download run_analysis.R from https://github.com/HelpfulMe/GetCleanDataProject
* In R, source the run_analysis code to run run_analysis (you can use 'source("run_analysis.R")')
* Code will create a tidy dataset titled "mytidydata.txt" in the user's working directory
* Tidy data can be loaded into R by using: 'mytidydata <- read.table("mytidydata.txt", header = TRUE)'
* View tidy data by using 'View(mytidydata)'
