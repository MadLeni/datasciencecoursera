## Loading and subsetting of the data 
dat <- read.table("household_power_consumption.txt",sep=";",header=TRUE)
dat[,1]<-as.Date(dat[,1],format="%d/%m/%Y")
ind <- which(dat[,1]=="2007-02-01" | dat[,1]=="2007-02-02")
subdat <- dat[ind,]

png(filename="plot1.png")
  hist(as.numeric(sub("","",subdat$Global_active_power)),col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.off()
