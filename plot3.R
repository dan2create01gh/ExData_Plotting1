a<-read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings = "?")
a$Date<-as.Date(a$Date, "%d/%m/%Y")

a<-subset(a,Date>=as.Date("2007-02-01")& Date<=as.Date("2007-02-02"))
a$date_time<-strptime(paste(a$Date,a$Time),"%Y-%m-%d %H:%M:%S")

png('plot3.png')

plot(a$date_time,a$Sub_metering_1,type="l", xaxt = "n",xlab="",ylab="Energy sub metering")
points(a$date_time,a$Sub_metering_2,type="l",col="red")
points(a$date_time,a$Sub_metering_3,type="l",col="blue")
legend("topright",col=c("black","red","blue"),lty=1,legend=paste("Sub_metering_",c(1,2,3),sep=""))

# My local time is not in english, need to change the axis tick-labels manually: 
# insert the new axis (days of the week) via axis.POSIXct.
axisloc<-subset(a, Time=="00:00:00")
axisloc<-axisloc$date_time
axisloc<-c(axisloc,axisloc[-1]+60*60*24)
axis.POSIXct(side=1,a$date_time,at=axisloc,labels=wday(axisloc,label=TRUE))

dev.off()
