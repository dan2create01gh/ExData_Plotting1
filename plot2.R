a<-read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings = "?")
a$Date<-as.Date(a$Date, "%d/%m/%Y")

a<-subset(a,Date>=as.Date("2007-02-01")& Date<=as.Date("2007-02-02"))

a$date_time<-strptime(paste(a$Date,a$Time),"%Y-%m-%d %H:%M:%S")

png('plot2.png')
plot(a$date_time,a$Global_active_power,type="l", xaxt = "n",xlab="",ylab="Global Active Power (kilowatts)")

# My local time is not in english, need to change the axis tick-labels manually: 
# insert the new axis (days of the week) via axis.POSIXct.
axisloc<-subset(a, Time=="00:00:00")
axisloc<-axisloc$date_time
axisloc<-c(axisloc,axisloc[-1]+60*60*24)
axis.POSIXct(side=1,a$date_time,at=axisloc,labels=wday(axisloc,label=TRUE))
dev.off()
  



