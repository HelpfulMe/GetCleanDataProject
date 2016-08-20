# GetCleanDataProject
Public repo for my Getting and Cleaning Data Course Project on Coursera

include a README.md in the repo describing how the script works

In the submission box, as well as the link, put some accompanying text on another line something like "tidy data as per the ReadMe that can be read into R with read.table(header=TRUE) {listing any settings you have changed from the default}" This is just to make it really easy for your reviewer.
In the readMe in explaining what the script does put "and then generates a tidy data text file that meets the principles of .etc"
the truly cunning may want to put in a citation to this discussion and/or Hadley's paper
The codebook still has the specific description of the tidy data file contents (and you mention that it exists and it's role in the ReadMe)
##README.md

##CodeBook.md
Contains description of the tidy data set

##run_analysis.R
Code that creates 'mytidydata.txt' file with tidy data from the UCI HAR dataset
To use: 
*Download run_analysis.R
*Download Samsung data to working directory (per assignment instructions, data is assumed to already be loaded in the user's working directory: 
###      "The code should have a file run_analysis.R in the 
###      main directory that can be run as long as the Samsung data is in your 
###      working directory"

##myTidyData.txt
Text file containing tidy data as described in codebook.md
Tidy data can be loaded into R by using: 
*data <- read.table(file_path, header = TRUE)*
*view(data)*
where 'file_path' is the location of the mytidydata.txt file on the computer