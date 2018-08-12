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

hist(hpcReq$Global_active_power, col ="red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

dev.copy(png, "plot1.png")
dev.off()

