## load necessary package and unzip file
library(dplyr) 
unzip("exdata.zip", exdir="exdata")

## load data specifying separator, column classes, and na types
household <- read.csv("exdata/household_power_consumption.txt", sep=";", 
                      colClasses = c("character", "character", "numeric", "numeric","numeric", "numeric", "numeric",
                                     "numeric", "numeric"), strip.white = TRUE, na.strings = c("?",""))

## subset data to relevant dates
household <- rbind(filter(household, Date=="1/2/2007"), filter(household, Date=="2/2/2007"))

## convert date and time to date format and create vector of combined date and time
datetime <- strptime(paste(household$Date, household$Time), "%d/%m/%Y %H:%M:%S")

## remove original date and time columns
household <- household[, -c(1,2)]

## add combined datetime
household <- cbind(datetime, household)

## open png device
dev.copy(png, "plot3.png")
png(file="plot3.png", width=480, height=480)

## create plot and turn off device
with(household, plot(DateTime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
lines(DateTime, household$Sub_metering_2, type="l", col="red")
lines(DateTime, household$Sub_metering_3, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"))
dev.off()