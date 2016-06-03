#  README file explains the R code to generate the tidy data
1. First import plyr library and import all the relavent data set.
2. After combine the train and test raw data as train_test,
   generate features subject to obtain the names and indices that
   only contain "mean" and "std" as required by the assignment.
3. Then create Activity_Labels column substituting numbers with
   descriptive activity names and combine this column to the main
   dataset. The new main data set is now: train_test_sub
4. Then make the column names more descriptive by:
   "t" at the very beginning is substituted by "time", "f" at the 
   beginning is substituted to frequency,"ACC" to "Accelerator",
   "Gyro" to "Gyroscope","Mag" to "Magnitude".
   For example, the original variable: tBodyAcc-mean()-X becomes 
   timeBodyAccelerator-mean()-X.
5. Then create the "Participant" column and combine to the main data set.
6. At last for the second tidy data set I calculate the average of each 
  variable for each activity and each subject.So there is 30 times 6 
  rows in the second tidy data frame called summary_train_test_sub.

