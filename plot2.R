library(dplyr)
Sys.setenv(LANG = "en_US.UTF-8")

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
     xaxt = "n",
     ylab = "Global Active Power (kilowatts)")

# Use english abbreviations for days as ticks on the x axis
axis(1,
     at = c(as.POSIXct("2007-02-01", tz = "GMT"),
            as.POSIXct("2007-02-02", tz = "GMT"),
            as.POSIXct("2007-02-03", tz = "GMT")),
     labels = c("Thu", "Fri", "Sat"))

dev.copy(png, "plot2.png")
dev.off()
