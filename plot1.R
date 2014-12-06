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
dev.copy(png, "plot1.png")
png(file="plot1.png", width=480, height=480)

## create plot and turn off device
with(household, hist(household$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red"))
dev.off()