library(dplyr)

# Load the data

data <- read.csv("household_power_consumption.txt",
                 header = T,
                 sep = ";",
                 na.strings = c("?"),
                 blank.lines.skip = T)

# Reformat some columns

data <- mutate(data,
               DateTime = as.POSIXct(paste(data$Date, data$Time),
                                     format = "%d/%m/%Y %H:%M:%S",
                                     tz     = "GMT"))

data.relevant <- data[data$DateTime >= as.POSIXct("2007-02-01", tz = "GMT") &
                      data$DateTime <  as.POSIXct("2007-02-03", tz = "GMT"), ]

# Start plotting

## Common options

par(mfrow = c(2,2))

xTicks <- c(as.POSIXct("2007-02-01", tz = "GMT"),
            as.POSIXct("2007-02-02", tz = "GMT"),
            as.POSIXct("2007-02-03", tz = "GMT"))
xTicksLab <- c("Thu", "Fri", "Sat")
            
## Plot 1 (top left)

plot(data.relevant$DateTime,
     data.relevant$Global_active_power,
     type = "l",
     xlab = "",
     xaxt = "n",
     ylab = "Global Active Power (kilowatts)")

# Use english abbreviations for days as ticks on the x axis
axis(1, at = xTicks, labels = xTicksLab)

## Plot 2 (top right)

plot(data.relevant$DateTime,
     data.relevant$Voltage,
     type = "l",
     xlab = "datetime",
     xaxt = "n",
     ylab = "Voltage")

# Use english abbreviations for days as ticks on the x axis
axis(1, at = xTicks, labels = xTicksLab)

## Plot 3 (bottom left)

plot(data.relevant$DateTime,
     data.relevant$Sub_metering_1,
     type = "l",
     xlab = "",
     xaxt = "n",
     ylab = "Energy sub metering")
lines(data.relevant$DateTime,
      data.relevant$Sub_metering_2,
      col = "red")
lines(data.relevant$DateTime,
      data.relevant$Sub_metering_3,
      col = "blue")

# Use english abbreviations for days as ticks on the x axis
axis(1, at = xTicks, labels = xTicksLab)

par(mar = c(4,4,4,4))
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col    = c("black", "red", "blue"),
       lty    = c(1,1,1),
       bty    = "n")

## Plot 4 (bottom right)

plot(data.relevant$DateTime,
     data.relevant$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     xaxt = "n",
     ylab = "Voltage")

# Use english abbreviations for days as ticks on the x axis
axis(1, at = xTicks, labels = xTicksLab)

# Write the figure to disk

dev.copy(png, "plot4.png")
dev.off()