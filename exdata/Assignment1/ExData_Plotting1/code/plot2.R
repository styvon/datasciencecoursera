source("./code/getdata.R")
png(file = "./figure/plot2.png", width = 480, height = 480)
plot(sdata$Dtime, sdata[,3], type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()
