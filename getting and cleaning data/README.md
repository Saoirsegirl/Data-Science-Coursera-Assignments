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



 
`merge_data` which will handle the the 1st, 3rd, and 4th requirements
`extract_mean_std` which will handle the 2nd, 3rd, and 4th requirements
`melt_data_and_write_tidy_set` which will handle the 5th requirement and write out the tidy set file

A helper function `read_tidy_set` is provided to read the generated tidy_set inside R.

### merge_data

 Purpose: to merge all the data from the various text files into a single giant data table. No subset or extractions performed on the data set once merged.
 
 Parameters: 
    `directory`: a character vector that indicates the folder residing inside the working directory
    
 Value:
    `all_data`: a merged data table containing training and test data and 3 additional columns for subject, activity, and activity id. This amounts to 10299 observations of 564 variables
    
### extract_mean_std

 Purpose: Performs subset on the giant data set of merged data to extract just the mean and std related data

 Parameters: 
    `data_set`: a data table containing the training set and test set data and 3 additional columns for subject, activity, and activity id
    `directory`: a character vector that indicates the folder residing inside the working directory
    
 Value:
    `extracted_data_set`: after performing subset on the `data_set` parameter, this is a data table that contains just 10299 observations of 69 variables basically the same 3 additional columns of subject, activity, and activity id plus the 66 columns whose headers contain the characters `mean()` and `std()`
    
### melt_data_and_write_tidy_set

 Purpose: Performs melt data, casting back to tidy data format, and then writing the data out to a text file

 Parameters: 
    `extracted_mean_std_data_set`: a data table containing the training set and test set data and 3 additional columns for subject, activity, and activity id but has already extracted out the mean and std columns
    `path_to_tidyset_file`: a character vector that indicates the path to write the tidy set file to 
    
 Value:
    nil
    
### read_tidy_set

 Purpose: Reads the tidy set file back into data table

 Parameters: 
    `path_to_tidyset_file`: a character vector that indicates the path to the tidy set file
    
 Value:
    datatable of data inside the tidy set file