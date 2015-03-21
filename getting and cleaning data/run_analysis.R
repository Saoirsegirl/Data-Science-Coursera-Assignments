## unzip file.
## unzip(zipfile="getdata-projectfiles-UCI HAR Dataset.zip", exdir=getwd())
## UCI HAR Dataset

library(dplyr)

activity <- read.table("./UCI HAR Dataset/activity_labels.txt", head = FALSE)
names(activity) <- c("activityId", "activityLabel")

features <- read.table("./UCI HAR Dataset/features.txt",  head = FALSE, stringsAsFactor = FALSE)

## Read train data set
train.sub <- read.table("./UCI HAR Dataset/train/subject_train.txt", head = FALSE)

train.y <- read.table("./UCI HAR Dataset/train/Y_train.txt", head = FALSE)

train <- read.table("./UCI HAR Dataset/train/X_train.txt", head = FALSE)
train <- train %>% mutate(V562 = train.y[,1], V563 = train.sub[,1])

## rm(train.y)
## rm(train.sub)

## Read test data set
test.sub <- read.table("./UCI HAR Dataset/test/subject_test.txt", head = FALSE)

test.y <- read.table("./UCI HAR Dataset/test/Y_test.txt", head = FALSE)

test <- read.table("./UCI HAR Dataset/test/X_test.txt", head = FALSE)
test <- test %>% mutate(V562 = test.y[,1], V563 = test.sub[,1])

## combine data into one dataset
allData <- rbind(train,test)

## Select columns we want
mean.sd.features <- features[grep("mean|std", features[,2]),]
## add activityId and subject to above list
mean.sd.features <- mean.sd.features%>%rbind(data.frame(V1 = c(562, 563), V2 = c("activityId", "subject")))

## remove unwanted columns from dataset
allData <- allData %>% select(mean.sd.features[,1])

## add appropriate variable names
names(allData) <- mean.sd.features[,2]

## add activity names column
allData <- allData %>% mutate(activityLabel = activity[allData$activityId,]$activityLabel)

## create a tidy dataset
tidy <- allData%>% group_by(activityLabel, subject) %>% summarise_each(funs(mean))

write.table(tidy, file = "./tidy_data.txt")

## rm(test.y)
## rm(test.sub)




