## Usage:
## source("plot4.R")
## plot4()
## 
plot4 <- function() {
  # read data from lokal disk
  data <- read.table("../household_power_consumption.txt", 
                     sep=";", header=TRUE, na.strings = "?")
  
  #filter by date
  filtered <- subset(data, data$Date=="1/2/2007" | data$Date=="2/2/2007")
  
  # merge date and time fiels in a field called DateTime
  filtered <- within(filtered, DateTime <- paste(filtered$Date, filtered$Time))
  
  # convert datetime
  filtered$DateTime = as.POSIXct(strptime(filtered$DateTime, format = "%d/%m/%Y %H:%M:%S"))
  
  # remove invalid data
  good <- complete.cases(filtered)
  cleaned <- filtered[good, ]
  
  # plot data
  png("plot4.png", width = 480, height = 480, bg="transparent")
  # set the layout - 2 rows / 2 columns
  par(mfrow=c(2,2))
  with(cleaned, {
      # plot 1 
      plot(cleaned$DateTime, cleaned$Global_active_power, type="l",
                     ylab="Global Active Power", xlab="")
      # plot 2
      plot(cleaned$DateTime, cleaned$Voltage, type="l",
                     ylab="Voltage", xlab="dateime")
      # plot 3
      with(cleaned, plot(cleaned$DateTime, cleaned$Sub_metering_1, type="l",
                          ylab="Energy sub metering", xlab=""))
      lines(cleaned$DateTime, cleaned$Sub_metering_2, col="red")
      lines(cleaned$DateTime, cleaned$Sub_metering_3, col="blue")
      legend("topright", 
              lty=1, 
              col = c("black", "red", "blue"), 
              legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
       # plot 4
       plot(cleaned$DateTime, cleaned$Global_reactive_power, type="l",
                     ylab="Global_reactive_power", xlab="datetime")
    
    })
  dev.off()
}

