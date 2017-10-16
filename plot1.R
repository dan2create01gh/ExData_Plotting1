a<-read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings = "?")
a$Date<-as.Date(a$Date, "%d/%m/%Y")

a<-subset(a,Date>=as.Date("2007-02-01")& Date<=as.Date("2007-02-02"))

png('plot1.png')
hist(a$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.off()