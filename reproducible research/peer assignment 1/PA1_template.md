---
title: "Reproducible Research Peer Assignment 1"
author: "Dhruv Mishra"
output: html_document
---


```r
library(lattice)
library(plyr)
library(dplyr)
```

## Load Data into Workspace

It is assumed that the .csv file is present in the workspace directory (hence the working directory is not being set).


```r
activity <- read.csv(file="activity.csv", header=TRUE, stringsAsFactors=F, quote="\"")
```

##### Convert date field to class type Date.


```r
activity <- mutate(activity, date = as.Date(date, "%Y-%m-%d"))
```

## What is mean total number of steps taken per day?

Get the vector containing the number of steps taken on each day. Plot the histogram for this data.

```r
step_num <- sapply(split(activity$steps, activity$date), sum, na.rm=TRUE)
hist(step_num, xlab="Total Steps per Day", ylab="Frequency", main="Histogram of Total Steps taken per day", breaks=25)
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3-1.png) 

```r
mean <- format(round(mean(sapply(split(activity$steps, activity$date), sum), na.rm=TRUE),3),nsmall=2)
median <- median(sapply(split(activity$steps, activity$date), sum), na.rm=TRUE)
```

The mean is **10766.19** and the median is **10765**.

## What is the average daily activity pattern?

### Time series plot of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all days (y-axis)


```r
by_interval <- group_by(activity, interval)
avg_steps <- summarise(group_by, steps.in.interval  = mean(steps, na.rm = TRUE))
```

```
## Error: is.data.frame(.data) || is.list(.data) || is.environment(.data) is not TRUE
```

```r
with(avg_steps, 
     plot(interval, steps.in.interval, type="l", 
          xlab="Time Intervals (5-minute)", 
          ylab="Average Steps Taken (across all days)", 
          main="Average No of Steps Taken every 5 Minutes "))
```

```
## Error in with(avg_steps, plot(interval, steps.in.interval, type = "l", : object 'avg_steps' not found
```

```r
max_steps_interval <- avg_steps[which.max(avg_steps$steps.in.interval), ]$interval
```

```
## Error in eval(expr, envir, enclos): object 'avg_steps' not found
```

```r
max_steps <- max(avg_steps$steps.in.interval)
```

```
## Error in eval(expr, envir, enclos): object 'avg_steps' not found
```
### Which 5-minute interval, on average across all the days in the dataset, contains the maximum number of steps?
The 5-minute interval containing the maximum number of steps starts at  in the dataset (i.e. the total number of rows with NAs)

```r
total_missing_val <- sum(is.na(activity))
```
**2304** values are missing.

### Devise a strategy for filling in all of the missing values.
A good strategy can be replacing the missing values with the mean for the corresponding 5-minute interval.

### Create a new dataset that is equal to the original dataset but with the missing data filled in.


```r
new_activity <- activity %>% left_join(avg_steps, by = "interval")
```

```
## Error in is.data.frame(y): object 'avg_steps' not found
```

```r
## remove NA
new_activity <- new_activity %>% within(steps[is.na(steps)] <- steps.in.interval[is.na(steps)])
```

```
## Error in eval(expr, envir, enclos): object 'new_activity' not found
```

```r
## remove steps.in.interval column
new_activity <- new_activity %>% within(rm(steps.in.interval))
```

```
## Error in eval(expr, envir, enclos): object 'new_activity' not found
```

### Make a histogram and report the mean and median

```r
new_step_num <- sapply(split(new_activity$steps, new_activity$date), sum, na.rm=TRUE)
```

```
## Error in split(new_activity$steps, new_activity$date): object 'new_activity' not found
```

```r
hist(new_step_num, xlab="Total Steps per Day", ylab="Frequency", main="Steps taken per day with NA values replaced", breaks=25)
```

```
## Error in hist(new_step_num, xlab = "Total Steps per Day", ylab = "Frequency", : object 'new_step_num' not found
```

```r
new_mean <- format(round(mean(sapply(split(new_activity$steps, new_activity$date), sum), na.rm=TRUE),2),nsmall=2)
```

```
## Error in split(new_activity$steps, new_activity$date): object 'new_activity' not found
```

```r
new_median <- format(round(median(sapply(split(new_activity$steps, new_activity$date), sum), na.rm=TRUE),2),nsmall=2)
```

```
## Error in split(new_activity$steps, new_activity$date): object 'new_activity' not found
```




