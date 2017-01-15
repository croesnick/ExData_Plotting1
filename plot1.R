data <- read.csv("household_power_consumption.txt",
                 header = T,
                 sep = ";",
                 na.strings = c("?"),
                 blank.lines.skip = T)

data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- strptime(data$Time, format = "%H:%M:%S", tz = "GMT")

data.relevant <- data[data$Date == as.Date("2007-02-1") |
                      data$Date == as.Date("2007-02-2"),]

hist(data.relevant$Global_active_power,
     col  = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency")

dev.copy(png, "plot1.png")
dev.off()
