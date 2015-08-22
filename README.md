# Coursera Getdata Project

## run_analysis.R
run_analysis("UCI HAR Dataset") expects data in the current working directory. Here is the algorithm it uses
1. Read feature names and filter names which have mean() and std() mentioned in them
2. Read test and train data for subject, activity and X
3. Create a data frame with columns activity, subject id and 79 variables from step #1
4. Create a tidy data frame (tidy data set) of the long form: (Activity, Subject ID, Feature, Average) using a loop
	* For every combination of (Activity, Subject ID, Feature)
		* calculate mean

## Why the data produced is considered tidy
The final output is a long form tidy data which has one variable per column.
Following a database normalization justification, the key (Activity, Subject ID, Feature) uniquely determines the mean, and
No subset of the candidate key (Activity, Subject ID, Feature) can unique determine the variable Average

## CodeBook
See CodeBook.md

## Data source
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


