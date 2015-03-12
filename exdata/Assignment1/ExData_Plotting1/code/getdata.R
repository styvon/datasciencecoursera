if (!file.exists("household_power_consumption.txt")) {
  url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url, destfile = "./data.zip", method = "curl")
  unzip("data.zip")
} 

# read in only the first 50 days of data
dir <- "./household_power_consumption.txt"
data <- read.table(dir, sep = ";", header = T, na.strings = "?", nrows = 72000) 

# select data from 2007-02-01 and 2007-02-02
cue = c("1/2/2007", "2/2/2007")
sdata = data[data$Date %in% cue,]

# data cleaning
dtime <- paste(sdata$Date, sdata$Time)
sdata$Dtime <- as.POSIXct(strptime(dtime, "%d/%m/%Y %H:%M:%S"))
