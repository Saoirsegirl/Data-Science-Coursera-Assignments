# CodeBook
Description: a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 

## Assumptions
It is assumed that the Samsung data is unzipped into the working directory. The data therefore resides in the same folder as `run_analysis.R`

In other words, it should be like this:
```
 ---
  |
  |---run_analysis.R
  |
  |---UCI HAR Dataset/
```

## Variables
The variables used or created are described as follows.
- activity : data frame containing the "activity_labels.txt" data set.
- features : data frame containing the "features.txt" data set.
- train.sub : data frame containing the "train/subject_train.txt" data set.
- train.y : data frame containing the "train/Y_train.txt" data set.
- train : data frame containing the "train/x_train.txt" data set.
- train$V562 : Contains the data from train.y
- train$V563 : Contains the data from train.sub
- test.sub : data frame containing the "test/subject_test.txt" data set.
- test.y : data frame containing the "test/Y_test.txt" data set.
- test : data frame containing the "test/x_test.txt" data set.
- test$V562 : Contains the data from test.y
- test$V563 : Contains the data from test.sub
- allData : data frame contained the combined data.
- mean.sd.features : A subset of activity data frame containing the required mean and stanadard deviation columns.
- tidy : contains the tidy data set required in point 5.
