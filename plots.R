#plots.R
#this code is used for the second problem in the miniproject.

data <- read.table("specdata/household_power_consumption_data/household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

data$Date <- as.Date(data$Date, "%d/%m/%Y")
data <- subset(data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
data <- data[complete.cases(data),]
dateAndTime <- paste(data$Date, data$Time)
dateAndTime <- setNames(dateAndTime, "dateAndTime")
data <- data[ ,!(names(data) %in% c("Date","Time"))]
data <- cbind(dateAndTime, data)
data$dateAndTime <- as.POSIXct(dateAndTime)

#plots don't show up after running dev.off. Restarting the program turns everything back to normal. 
#Ma'am comment nalang po all the dev. lines except for one plot (depends on which plot you want to display/save.)

################################################################################################################
#Plot 1

hist(data$Global_active_power, col="red" , main ="Global Active Power" , xlab = "Global Active Power (kilowatts)", ylab="")

#dev.copy(png,"plot1.png")
#dev.off()

################################################################################################################
#Plot 2

plot(data$Global_active_power~data$dateAndTime, type="l", xlab="", ylab="Global Active Power (kilowatts)")

#dev.copy(png,"plot2.png")
#dev.off()

################################################################################################################
#Plot 3

with(data, {
  plot(Sub_metering_1~dateAndTime, type="l", ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~dateAndTime,col='Red')
  lines(Sub_metering_3~dateAndTime,col='Blue')
  })

legend("topright", col=c("black", "red", "blue"), lwd=c(2,2,2), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#dev.copy(png,"plot3.png")
#dev.off()

################################################################################################################
#Plot 4

par(mfrow=c(2,2), mar=c(5,5,2,2), oma=c(0,0,2,0))

with(data, {
  plot(Global_active_power~dateAndTime, type="l", 
       ylab="Global Active Power", xlab="")
  
  plot(Voltage~dateAndTime, type="l", 
       ylab="Voltage", xlab="datetime")
  
  plot(Sub_metering_1~dateAndTime, type="l", 
       ylab="Energy Sub metering", xlab="")
  lines(Sub_metering_2~dateAndTime,col='Red')
  lines(Sub_metering_3~dateAndTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(Global_reactive_power~dateAndTime, type="l", 
       ylab="Global_reactive_power",xlab="datetime")
})

#dev.copy(png,"plot4.png")
#dev.off()
################################################################################################################