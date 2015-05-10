## loadin libraries
library(dplyr)
library(data.table)

##      READING AND PREPERING DATA

## reading data

setwd("C:/D/=kursy=/DataScienceTrack/4. Exploratory Data Analysis/project 1")

data<- fread("household_power_consumption.txt")
# selecting rows; changing the type of data 
data <- data.frame(filter(data, Date %in% c("1/2/2007", "2/2/2007")))


######################################
## alternative way of reading data
## library(sqldf)
## data2<-read.csv.sql(file = "household_power_consumption.txt", 
##                   sql = "select * from file where Date in ('1/2/2007', '2/2/2007')", sep=";")
######################################

# changing types of variables
data$datetime<-strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
data$Date<-as.Date(data$Date, format="%d/%m/%Y")
data$Global_active_power<-as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)
data$Global_intensity <- as.numeric(data$Global_intensity)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

# str(data)

##      PLOT 4
sessionInfo()
Sys.setlocale("LC_TIME", "us")
par(mfcol = c(2, 2))

# plot 2
plot(data$datetime, data$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")
# plot 3
plot(data$datetime, data$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
lines(data$datetime, data$Sub_metering_1)
lines(data$datetime, data$Sub_metering_2, col = "red")
lines(data$datetime, data$Sub_metering_3, col = "blue")
legend(x="topright",bty="n", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_2"), col=c("black", "red", "blue"), lty=1, cex=0.6)

plot(data$datetime, data$Voltage, type="l", xlab = "datetime", ylab = "Voltage" )
plot(data$datetime, data$Global_reactive_power, type="l", xlab = "datetime", ylab = "Global reactive power" )

#dev.print(device = png, file="plot4_1.png", width = 480, height = 480)

png("plot4.png", width = 480, height = 480)
sessionInfo()
Sys.setlocale("LC_TIME", "us")
par(mfcol = c(2, 2))
plot(data$datetime, data$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")
# plot 3
plot(data$datetime, data$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
lines(data$datetime, data$Sub_metering_1)
lines(data$datetime, data$Sub_metering_2, col = "red")
lines(data$datetime, data$Sub_metering_3, col = "blue")
legend(x="topright",bty="n", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_2"), col=c("black", "red", "blue"), lty=1)

plot(data$datetime, data$Voltage, type="l", xlab = "datetime", ylab = "Voltage" )
plot(data$datetime, data$Global_reactive_power, type="l", xlab = "datetime", ylab = "Global reactive power" )
dev.off()
