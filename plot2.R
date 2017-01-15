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
     data.relevant$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

dev.copy(png, "plot2.png")
dev.off()
