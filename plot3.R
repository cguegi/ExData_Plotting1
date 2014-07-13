## Usage:
## source("plot3.R")
## plot3()
## 
plot3 <- function() {
  # read data from lokal disk
  data <- read.table("../household_power_consumption.txt", sep=";", header=TRUE, na.strings = "?")
  
  #filter by date
  filtered <- subset(data, data$Date=="1/2/2007" | data$Date=="2/2/2007")
  
  # merge date and time in new field called DateTime
  filtered <- within(filtered, DateTime <- paste(filtered$Date, filtered$Time))
  
  # convert datetime
  filtered$DateTime = as.POSIXct(strptime(filtered$DateTime, format = "%d/%m/%Y %H:%M:%S"))
  
  # remove invalid data
  good <- complete.cases(filtered)
  cleaned <- filtered[good, ]
  
  # plot data
  png("plot3.png", width = 480, height = 480, bg="transparent")
  with(cleaned, plot(cleaned$DateTime, cleaned$Sub_metering_1, type="l",
       ylab="Energy sub metering", xlab=""))
  # add two more lines
  lines(cleaned$DateTime, cleaned$Sub_metering_2, col="red")
  lines(cleaned$DateTime, cleaned$Sub_metering_3, col="blue")
  # add legend
  legend("topright", 
         lty=1, 
         col = c("black", "red", "blue"), 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  dev.off()
}

