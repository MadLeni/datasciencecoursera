## Loading and subsetting of the data 
dat <- read.table("household_power_consumption.txt",sep=";",header=TRUE)
dat[,1]<-as.Date(dat[,1],format="%d/%m/%Y")
ind <- which(dat[,1]=="2007-02-01" | dat[,1]=="2007-02-02")
subdat <- dat[ind,]

png(filename="plot3.png")
  plot(as.numeric(sub("","",subdat$Sub_metering_1)),type="l",ylab="Energy sub metering",xaxt="n",xlab="")
  axis(1, at = c(0,1440,2880), labels = c("Thu","Fri","Sat"), tick = TRUE)
  lines(as.numeric(sub("","",subdat$Sub_metering_2)),col="red")
  lines(as.numeric(sub("","",subdat$Sub_metering_3)),col="blue")
  legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"))
dev.off()