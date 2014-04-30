GettingandCleaningData
======================
Getting and Cleaning Data

The assignments consisted with five aims:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

First of all, I changed the variable names. Because special characters like ( ) - are cumbersome to treat in conventional programming. For the aim, ( ) ? are changed to _ (underbar)

Second, activity labels were mapped by using the mapping table (Aim 4)

Third, training and the test sets were merged to create one data set.
Fourth, variables having mean and standard deviation were extracted. However variables only having meand( ) or std( ) were selected., intentionally.
Last, second, independent tidy data set with the average of each variable for each activity and each subject were made. For this, each activity for each subject were applied.  Thus, each patients can have up to 6 rows. However most of the subject had only one activity.

####################