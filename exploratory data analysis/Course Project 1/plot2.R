#### This code is for Plot 1 of project 1 for the Coursera course "Exploratory Data Analysis"
#### Date: March 8, 2015
#### Author: Dhruv Mishra

## Assume that file is present in the same directory as this script


######### Load data.table library #########
library(data.table)

data <- fread("household_power_consumption.txt")

######### Clean data #########

# Change the format of Date variable
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# Subset the data for the two dates of interest
data_subset <- data[data$Date=="2007-02-01" | data$Date=="2007-02-02"]

# Convert data subset to a data frame
data_subset <- data.frame(data_subset)

# Convert columns to numeric
for(i in c(3:9)) {data_subset[,i] <- as.numeric(as.character(data_subset[,i]))}

# Convert Time variable to proper format
data_subset$Time <- strptime(paste(data_subset$Date, data_subset$Time), format="%Y-%m-%d %H:%M:%S")

######### Plot 2 #########

png(filename = "plot2.png", width = 480, height = 480, units = "px", bg = "white")

par(mar = c(6, 6, 5, 4))

plot(data_subset$Time, data_subset$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type="n")

lines(data_subset$Time, data_subset$Global_active_power, type="S")

dev.off()