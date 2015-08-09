# Coursera JHPH Data Science
# 004 - Exploratory Data Analysis
# Week 1 | Course Project 1
#
# Joe Nguyen | 10 Aug, 2015

rm(list = ls())

## Read data
library(data.table)
pwrConData <- fread("./data/household_power_consumption.txt")
pwrConData[pwrConData == "?"] <- NA
str(pwrConData)

# Convert [$Date, $Time] to [date, time] class
dateTime <- strptime(paste(pwrConData$Date, pwrConData$Time), "%d/%m/%Y %H:%M:%S")
pwrConData$Date <- as.Date(pwrConData$Date, "%d/%m/%Y")

# Convert other variables to numeric
for (i in 3:ncol(pwrConData)) {
    pwrConData[[i]] <- as.numeric(pwrConData[[i]])
}
str(pwrConData)

## Only use data in dates: 2007-02-01 and 2007-02-02
library(dplyr)
cstrDate <- pwrConData$Date == as.Date("2007-02-01", "%Y-%m-%d") | pwrConData$Date == as.Date("2007-02-02", "%Y-%m-%d")
explrData <- filter(pwrConData, cstrDate)
explrTime <- dateTime[cstrDate]
str(explrData)
nrow(explrData) == length(explrTime)

###########
## Plot 3
# Global Active Power vs time
png(file = "plot3.png")
plot(explrTime, explrData$Sub_metering_1, col = "black", type = "l", xlab = "", ylab = "Energy sub metering")
lines(explrTime, explrData$Sub_metering_2, col = "red")
lines(explrTime, explrData$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
