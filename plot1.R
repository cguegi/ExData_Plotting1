## Usage:
## source("plot1.R")
## plot1()
## 
plot1 <- function() {
	# read data from disk
  data <- read.table("../household_power_consumption.txt", sep=";", header=TRUE, na.strings = "?")
	
  #convert date string into date object
	data$Date <- as.Date(data$Date,"%d/%m/%Y")
	
  # filter by date
  filtered <- data[data$Date %in% as.Date(c("2007-02-01","2007-02-02")), ]

  # remove invalid data
  good <- complete.cases(filtered)
	cleaned <- filtered[good, ]

  # plot data
  png("plot1.png", width = 480, height = 480, bg="transparent")
	hist(cleaned$Global_active_power, 
		main="Global Active Power", 
		xlab="Global Activity Power (kilowatts)",
		ylab="Frequency",  
		col="red")
	dev.off()
}