library(dplyr)

data <- read.csv("household_power_consumption.txt",
                 header = T,
                 sep = ";",
                 na.strings = c("?"),
                 blank.lines.skip = T)

data <- mutate(data,
               DateTime = as.POSIXct(paste(data$Date, data$Time),
                                     format = "%d/%m/%Y %H:%M:%S",
                                     tz     = "GMT"))

data.relevant <- data[data$DateTime >= as.POSIXct("2007-02-01", tz = "GMT") &
                        data$DateTime <  as.POSIXct("2007-02-03", tz = "GMT"), ]

plot(data.relevant$DateTime,
     data.relevant$Sub_metering_1,
     type = "l",
     xlab = "",
     ylab = "Energy sub metering")
lines(data.relevant$DateTime,
      data.relevant$Sub_metering_2,
      col = "red")
lines(data.relevant$DateTime,
      data.relevant$Sub_metering_3,
      col = "blue")

par(mar = c(4,4,4,4))
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col    = c("black", "red", "blue"),
       lty    = c(1,1,1))

dev.copy(png, "plot3.png")
dev.off()
