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

## adjust margins of plot
par(mar = c(5, 4, 4, 2))

## plot histogram of Global_active_power with appropriate plot parameters
hist(dataSubset$Global_active_power, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red", ylim= c(0, 1200), cex.axis = 0.6, cex.lab = 0.6, cex.main = 0.6)
