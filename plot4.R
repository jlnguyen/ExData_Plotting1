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
## Plot 4
# 4 subfigures
png(file = "plot4.png")
par(mfrow = c(2,2)) #, mar = c(4, 4, 2, 1), oma = c(0,0,2,0))

# 1) Global Active Power vs time
plot(explrTime, explrData$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

# 2) Voltage vs time
plot(explrTime, explrData$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

# 3) Global Active Power vs time
plot(explrTime, explrData$Sub_metering_1, col = "black", type = "l", xlab = "", ylab = "Energy sub metering")
lines(explrTime, explrData$Sub_metering_2, col = "red")
lines(explrTime, explrData$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.7)

# 4) Global Reactive Power vs time
plot(explrTime, explrData$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
points(explrTime, explrData$Global_reactive_power, pch = 20, cex = 0.2)
dev.off()

