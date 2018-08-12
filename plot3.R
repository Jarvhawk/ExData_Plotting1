if(!file.exists("./Electric_power_consumption.zip")) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl, destfile = "./Electric_power_consumption.zip", method = "curl")
  
}

if(!file.exists("household_power_consumption")) {
  unzip(zipfile = "./Electric_power_consumption.zip")
}

hpc <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", colClasses = "character")

hpcReq <- subset(hpc, Date == "1/2/2007" | Date == "2/2/2007")

hpcReq[,3:9] <- sapply(hpcReq[,3:9], as.numeric) #Converts columns 3 through 9 to numeric class

hpcReq$Date <- paste(hpcReq$Date, hpcReq$Time) #Merging Date and Time into one column
hpcReq$Date <- strptime(hpcReq$Date, format = "%d/%m/%Y %H:%M:%S") #Converting merged dateTime column into date class ("POSIXlt" and "POSIXct")
colnames(hpcReq)[1] <- "Date_Time"
hpcReq <- subset(hpcReq, select = -c(Time)) #Remove arbitrary Time column

png("plot3.png", width = 480, height = 480)

plot(hpcReq$Date_Time, hpcReq$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(hpcReq$Date_Time, hpcReq$Sub_metering_2, type = "l", col = "red")
lines(hpcReq$Date_Time, hpcReq$Sub_metering_3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, lwd = 2.5, col = c("black", "red", "blue"))

dev.off()
