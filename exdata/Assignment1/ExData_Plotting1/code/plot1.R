source("./code/getdata.R")
png(file = "./figure/plot1.png", width = 480, height = 480)
hist(sdata[,3], main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()