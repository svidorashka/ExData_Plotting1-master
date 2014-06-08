#download and unzip the file
RawFile <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",RawFile)
unzip(RawFile)
unlink(RawFile)



#filter the raw text file into a filtered file, which contains only the relevant dates
Unzipped<-file("household_power_consumption.txt", "r")
cat(grep("(^Date)|(^[1|2]/2/2007)",readLines(Unzipped), value=TRUE), sep="\n", file="filtered.txt")
close(Unzipped)

#Read data into Data.Frame
Data<-read.table("filtered.txt", sep=";", header=TRUE, quote="",na.string="?", stringsAsFactors=TRUE)

#Build the chart and copy to png

#define the time axis
x<-strptime(paste(Data$Date, Data$Time), "%d/%m/%Y %H:%M:%S");

#define the plotting matrix layout
par(mfrow=c(2,2))
par(mar=c(4,4,2,2))


#upper left plot
plot(x,Data$Global_active_power,typ='l', main="", xlab="", ylab="Global Active Power")

#upper right plot
plot(x,Data$Voltage,typ='l', main="", ylab="Voltage",xlab="datetime")

#lower left plot
plot(x,y,type="n", main="", ylab="Energy sub metering",xlab="", ylim=c(0, 39))
lines(x,Data$Sub_metering_1, col="black")
lines(x,Data$Sub_metering_2, col="red")
lines(x,Data$Sub_metering_3, col="blue")
legend("topright",bty="n", lty=1,col=c("black","red", "blue"),legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), cex=.7)


#lower right plot
plot(x,Data$Global_reactive_power,typ='l', main="",  ylab="Global_rective_power", xlab="datetime")


dev.copy(png, file = "Plot4.png") 
dev.off()
