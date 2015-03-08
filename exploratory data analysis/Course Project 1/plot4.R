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

######### Plot 4 #########

#### Turn on png device and set parameters
png(filename = "plot4.png", width = 480, height = 480, units = "px", bg = "white")
par(mfrow = c(2, 2), mar = c(14, 6, 2, 2), cex=.5)

#### Plot 2 in top left
plot(data_subset$Time, data_subset$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type="n")

lines(data_subset$Time, data_subset$Global_active_power, type="S")

#### Top right graph
plot(data_subset$Time, data_subset$Voltage, xlab = "datetime", ylab = "Voltage", type="n")

lines(data_subset$Time, data_subset$Voltage, type="S")

#### Plot 3 in bottom left
plot(data_subset$Time, data_subset$Sub_metering_1, xaxt=NULL, xlab = "", ylab = "Energy sub metering", type="n")
## Sets up the plot, but does not populate with any data

lines(data_subset$Time, data_subset$Sub_metering_1, col = "black", type = "S")
## Plots lines for sub_metering_1
lines(data_subset$Time, data_subset$Sub_metering_2, col = "red", type = "S")
## Plots lines for sub_metering_2
lines(data_subset$Time, data_subset$Sub_metering_3, col = "blue", type = "S")
## Plots lines for sub_metering_3

legend("topright", bty = "n", lty = c(1, 1), lwd = c(1, 1, 1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# Adds a legend with lines
# lwd = c(1, 1, 1) assigns the lines widths of 1
# lty = c(1, 1) assigns the line type within the legend
# bty = "n" sets the box type to none

#### Bottom right graph
plot(data_subset$Time, data_subset$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type="n")
# type = "n" builds plots without points

lines(data_subset$Time, data_subset$Global_reactive_power, type="S")

dev.off()