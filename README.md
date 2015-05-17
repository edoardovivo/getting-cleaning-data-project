# run_analysis script

The script run_analysis contains a function called tidyDataSamsung. Make sure your working directory is one node above the "UCI HAR Dataset" folder and then, to execute the script, run the following commands in R:

*       source("run_analysis.R")
*       data <- tidyDataSamsung() 

The script performs the following operations:

1. From the file "features.txt", it extracts all the variables names. By means of the "grep" function, it extract all those that contain "mean" or "std" in their names. 
2. It reads the file "activity_labels.txt" containing the activity names and the labels associated with them.
3. Using the information from point 1, it reads the files "X_train.txt" and "X_test.txt", extracting only the columns corresponding to the variables we need. It also assigns the variables names to each column.
4. It reads the files "y_train.txt" and "y_test.txt" containing the labels of the activities performed by each subject.
5. It reads the files "subject_train.txt" and "subject_test.txt" indicating the subject each observation is associated with.
6. It creates two data frames, data_train and data_test, by merging all the observations with the table of activities and activity labels. 
7. It merges the data_train and data_test sets, in a data frame containing, for each observation, the subject, the activity performed, and all the variables.
8. It renames the variables by dropping the parentheses.
8. Finally, it creates a data frame with the mean of each variable for each subject and activity.







