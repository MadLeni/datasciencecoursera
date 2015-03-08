## Loading and subsetting of the data 
dat <- read.table("household_power_consumption.txt",sep=";",header=TRUE)
dat[,1]<-as.Date(dat[,1],format="%d/%m/%Y")
ind <- which(dat[,1]=="2007-02-01" | dat[,1]=="2007-02-02")
subdat <- dat[ind,]

png(filename="plot4.png")
  par(mfrow=c(2,2))
  plot(as.numeric(sub("","",subdat$Global_active_power)),type="l",ylab="Global Active Power (kilowatts)",xaxt="n",xlab="")
  axis(1, at = c(0,1440,2880), labels = c("Thu","Fri","Sat"), tick = TRUE)

  plot(as.numeric(sub("","",subdat$Voltage)),type="l",ylab="Voltage",xaxt="n",xlab="datetime")
  axis(1, at = c(0,1440,2880), labels = c("Thu","Fri","Sat"), tick = TRUE)

  plot(as.numeric(sub("","",subdat$Sub_metering_1)),type="l",ylab="Energy sub metering",xaxt="n",xlab="")
  axis(1, at = c(0,1440,2880), labels = c("Thu","Fri","Sat"), tick = TRUE)
  lines(as.numeric(sub("","",subdat$Sub_metering_2)),col="red")
  lines(as.numeric(sub("","",subdat$Sub_metering_3)),col="blue")
  legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"),bty="n")

  plot(as.numeric(sub("","",subdat$Global_reactive_power)),type="l",ylab="Global_reactive_power",xaxt="n",xlab="datetime")
  axis(1, at = c(0,1440,2880), labels = c("Thu","Fri","Sat"), tick = TRUE)
dev.off()