## Loading and subsetting of the data 
dat <- read.table("household_power_consumption.txt",sep=";",header=TRUE)
dat[,1]<-as.Date(dat[,1],format="%d/%m/%Y")
ind <- which(dat[,1]=="2007-02-01" | dat[,1]=="2007-02-02")
subdat <- dat[ind,]

png(filename="plot2.png")
  plot(as.numeric(sub("","",subdat$Global_active_power)),type="l",ylab="Global Active Power (kilowatts)",xaxt="n",xlab="")
  axis(1, at = c(0,1440,2880), labels = c("Thu","Fri","Sat"), tick = TRUE)
dev.off()
