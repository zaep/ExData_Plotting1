# NOTE: set working directory to project root directory, e.g.:
# setwd("~/R/ExData_Plotting1")

# download and unzip dataset
if (!file.exists("data/household_power_consumption.txt")) {
  dir.create("data")
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                "data/exdata-data-household_power_consumption.zip",
                method = "auto")
  unzip("data/exdata-data-household_power_consumption.zip", exdir = "data")  
}

# temporarily switch locale to avoid region-specific datetime formatting issues
lct <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "C")

# read and subset data
data <- read.table("data/household_power_consumption.txt", header = TRUE, sep = ";",
           na.strings = "?", stringsAsFactors = FALSE)
data$Date <- as.Date(data$Date, "%d/%m/%Y")
df <- subset(data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))
# add new combined datetime feature
df$dt <- strptime(paste(as.character(df$Date), df$Time), "%Y-%m-%d %H:%M:%S")

# create plot
png("plot1.png")
hist(df$Global_active_power, col = 2, main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()

# set locale back to default
Sys.setlocale("LC_TIME", lct)