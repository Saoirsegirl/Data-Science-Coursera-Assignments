# Description

The requirements are:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
 
## How the script works
1. The script first loads the datasets of training, testing, activities and features.
2. The Y_*.txt and Subject_*.txt data frames are appended to the respective X_*.txt data set by adding additional columns.

3. Both the training and testing data frames are then combined into a single data frame named 'allData' using row bind function. This completes the 1st requirement.

4. The required features for 2nd requirement are first extracted into the data frame mean.sd.features. The activity and subject columns are added to mean.sd.features and then the unwanted columns from 'allData' are filtered out.

5. Using the foreign keys for activity labels present in 'allData', the actual labels as derived from the activity_labels.txt data set are added as an additional column to 'allData'. This completes 3rd requirement.

6. The 'mean.sd.features' data frame which also contains the labels of the required columns is used to name the columns of 'allData' using the names(...) function. This completes 4th requirement.

7. A new tidy data is then created by grouping 'allData' according to activity and subject and then calculating the mean. The result is then assigned to a new variable 'tidy' and the data contained is then written into a tidy_data.txt file.