a<-read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings = "?")
a$Date<-as.Date(a$Date, "%d/%m/%Y")

a<-subset(a,Date>=as.Date("2007-02-01")& Date<=as.Date("2007-02-02"))
a$date_time<-strptime(paste(a$Date,a$Time),"%Y-%m-%d %H:%M:%S")

# My local time is not in english, need to change the axis tick-labels manually: 
# insert the new axis (days of the week) via axis.POSIXct - several lines below.
axisloc<-subset(a, Time=="00:00:00")
axisloc<-axisloc$date_time
axisloc<-c(axisloc,axisloc[-1]+60*60*24)

png('plot4.png')

par(mfrow=c(2,2))

# 1st plot:
plot(a$date_time,a$Global_active_power,type="l", xaxt = "n",xlab="",ylab="Global Active Power")
axis.POSIXct(side=1,a$date_time,at=axisloc,labels=wday(axisloc,label=TRUE))

#2nd plot:
plot(a$date_time,a$Voltage,type="l", xaxt = "n",xlab="datetime",ylab="Voltage")
axis.POSIXct(side=1,a$date_time,at=axisloc,labels=wday(axisloc,label=TRUE))

# 3rd plot
plot(a$date_time,a$Sub_metering_1,type="l", xaxt = "n",xlab="",ylab="Energy sub metering")
points(a$date_time,a$Sub_metering_2,type="l",col="red")
points(a$date_time,a$Sub_metering_3,type="l",col="blue")
legend("topright",col=c("black","red","blue"),lty=1,legend=paste("Sub_metering_",c(1,2,3),sep=""),bty="n")
axis.POSIXct(side=1,a$date_time,at=axisloc,labels=wday(axisloc,label=TRUE))

# fourth plot
plot(a$date_time,a$Global_reactive_power,type="l", xaxt = "n",xlab="datetime",ylab="Global_reactive_power")
axis.POSIXct(side=1,a$date_time,at=axisloc,labels=wday(axisloc,label=TRUE))

dev.off()
