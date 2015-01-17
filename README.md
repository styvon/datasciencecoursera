## Intro
This is a repository for the Coursera *Getting and Cleaning Data* course project using [data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) extracted from [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
The objectives of the project are:
1. to merge the training and the test sets to create one data set;
2. to extract only the measurements on the mean and standard deviation for each measurement;
3. to name the activities in the data set using descriptive activity names;
4. to label the data set with descriptive variable names; and
5. to create a second, independent tidy data set with the average of each variable for each activity and each subject from the data set in Objective 4.

## What's in this repository
- 'README.md'
- 'CodeBook.md': describes the variables in the final tidy data set and how they are calculated
- 'run_analysis.R': the R script for performing the analysis, the final output is a data frame named "tidy"
- 'tidy.txt': the result of the analysis as a tidy data set, created by the command line *write.table(tidy, file="./tidy.txt", row.names = F)*

## How the analysis is performed: a brief walkthrough
NOTE that two addictional libraries (**dplyr** and **tidyr**) need to be downloaded beforehand, and that the objectives are achieved in an order of 1-4-2-3-5 instead of the original 1-2-3-4-5 order in this analysis. 
### Retrieve data
The first part of the R codes downloads the data set, unzip it to working directory and resets the working directory to the unzipped file.
### Create personalized functions
Two functions are created to facilitate the analysis process:
- afterspace(): a function that extracts character strings after a space (" ")
- myread(): a function (myread) that reads the contents in a directory (with the same structure as the "test" and "train" folder) seperately and returns a dataframe. The first 561 columns are measurement data extracted from "X_test.text"/"X_train.txt", the 562nd is activity label from "y_test.txt"/"y_train.txt", the 563rd is subject information from "subject_test.txt"/"subject_train.txt". 
### Objective 1: merge training and test data sets
Test and training data sets are read using *myread()* function and bound together by row using *rbind*.
### Objective 4: label data set with descriptive variable names
Descriptive variable names for the first 561 columns are extracted from "features.txt" using *readLines()* and *afterspace()*, the parentheses in the names are removed(*gsub*) to form a nicer format. The last 2 columns are named "label" and "subject" respectively.
### Objective 2: extract mean and std for each measurement
The pattern of variable names indicating the mean and std measurements can be concluded as *"mean[^Freq])|mean$|std"*(character strings that include "mean" but exclude "meanFreq", or ends with "mean", or strings that include "std"). The measurements can then be extracted with the *grep* command. The "label" and "subject" columns remain in the extracted data set by adding conditions in the expression.
### Objective 3: name activities
The numbers in the "label" column are substituded with descriptive activity names extracted from "activity_labels.txt" by looping the *gsub()* function.
### Objective 5: create the final tidy data set
Merge the two variables "label" and "subject" into new variable "labsub" using *mutate()* in the **dplyr** package. Then, *split()* the data set by "labsub" and *sapply()* to calculate the column means (*colMeans()*) of all but the last two columns.
Transpose the table and form a data frame so that each column is one measurement and each row represents a different activity and subject. Use *separate()* in the **tidyr** package to split the "labsub" variable back to "label" and "subject".
Move the "label" and "subject" columns to the first two columns and *arrange()* the "label"(as factor) by alphabetical order and "subject" by numeric order to get the final output (a data frame named "tidy")





    
