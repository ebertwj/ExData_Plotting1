## read header data from first line of data file
header <- read.table("C:/Users/bill/downloads/exdata_data_household_power_consumption/household_power_consumption.txt", nrows = 1, header = FALSE, sep = ";", na.strings = c("?"), stringsAsFactors = FALSE)

## read rest of data into data frame
data <- read.table("C:/Users/bill/downloads/exdata_data_household_power_consumption/household_power_consumption.txt", skip = 2, header = FALSE, sep = ";", na.strings = c("?"), stringsAsFactors = FALSE)

## change column names to names read from header
colnames(data) <- unlist(header)

## change data in Date column to date objects
data$Date <- as.Date(data$Date, "%d/%m/%Y")

## change data in Time column to date objects
data$Time <- strptime(data$Time, "%H:%M:%S")

## format time data in Time column to show time only
data$Time <- strftime(data$Time, "%H:%M:%S")

## set value for start of subset of data
startDate <- as.Date(c("01/02/2007"), "%d/%m/%Y")

## set value for end of subset of data
endDate <- as.Date(c("02/02/2007"), "%d/%m/%Y")

## subset data to dates of 1-2-2007 and 2-2-2007 only
dataSubset <- subset(data, Date == startDate | Date == endDate)

## combine date and time columns into single date object in Date column
dataSubset$Date <- as.POSIXct(paste(dataSubset$Date, dataSubset$Time), format="%Y-%m-%d %H:%M:%S")

## set margins for plot
par(mar = c(4, 4, 3, 1))

## set plot with labels
with(dataSubset, plot(Date, Sub_metering_1, xlab = "", ylab = "Energy sub metering", cex.axis = 0.6, cex.lab = 0.65, type = "n"))

## add lines for data
lines(dataSubset$Date, dataSubset$Sub_metering_1, type = "l")
lines(dataSubset$Date, dataSubset$Sub_metering_2, col = "red")
lines(dataSubset$Date, dataSubset$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = c(1, 1, 1), cex = 0.3)
