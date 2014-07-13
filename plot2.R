## Usage:
## source("plot2.R")
## plot2()
## 
plot2 <- function() {
	# read data from disk
  data <- read.table("../household_power_consumption.txt", sep=";", header=TRUE, na.strings = "?")
	
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
  png("plot2.png", width = 480, height = 480, bg="transparent")
  plot(cleaned$DateTime, 
       cleaned$Global_active_power, 
       type="l", 
       ylab = "Global Active Power (kilowatts)", 
       xlab = "")
  dev.off()
}

