# Procure data
url <- paste("https://d396qusza40orc.cloudfront.net/",
             "exdata/data/household_power_consumption.zip", sep = "")
filename <- "household_power_consumption"
if(!file.exists(paste(filename, ".zip", sep = ""))) {
    download.file(url, paste(filename, ".zip", sep = ""))
}
if(!file.exists(paste(filename, ".txt", sep = ""))) {
    unzip(paste(filename, ".zip", sep = ""))
}

# Read in data
library(readr)
hpc <- read_delim(txt.filename, delim = ";", col_types = "ctddddddd", na = "?")

library(dplyr)
hpc <- hpc %>%
    mutate(Date = as.Date(Date, format = "%d/%m/%Y")) %>%
    filter(Date >= "2007-02-01", Date <= "2007-02-02") %>%
    mutate(datetime = as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"))

# Draw plot
png("plot3.png")
with(hpc, plot(datetime,
               Sub_metering_1,
               type = "l",
               xlab = "",
               ylab = "Energy sub metering"))
with(hpc, points(datetime,
                 Sub_metering_2,
                 type = "l",
                 col = "red"))
with(hpc, points(datetime,
                 Sub_metering_3,
                 type = "l",
                 col = "blue"))
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lwd = 1)
dev.off()
