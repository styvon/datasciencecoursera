source("./code/getdata.R")
png(file = "./figure/plot4.png", width = 480, height = 480)

par(mfrow = c(2,2))
  plot(sdata$Dtime, sdata[,3], type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
  
  plot(sdata$Dtime, sdata[,5], type = "l", xlab = "datetime", ylab = "Voltage")
  
  plot(sdata$Dtime, sdata$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
  lines(sdata$Dtime, sdata$Sub_metering_2, col = "red")
  lines(sdata$Dtime, sdata$Sub_metering_3, col = "blue")
  legend("topright", names(sdata)[7:9], lty = 1, col = c("black", "red", "blue"))
  
  plot(sdata$Dtime, sdata[,4], type = "l", xlab = "datetime")

dev.off()
