setwd("C:/Users/Renaud/Rcourses/exploratory/week1/project")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip ","./week1.zip", mode="wb")
unzip ("week1.zip", exdir = getwd())

file<-read.csv("household_power_consumption.txt", sep=";")
file1<-file

library(data.table)

# take only February 2007 data subset for quicker calculation in next steps
file1<-subset(file1, file1$Date %like% "/2/2007")
              
file1$Date<-as.Date(file1$Date,"%d/%m/%Y")
#file1$Time<-as.POSIXct(file1$Time)
Date_hour<-paste(file1$Date,file1$Time)
Date_hour<-as.POSIXct (Date_hour)
file1<-file1[c(-1,-2)]
file2<-cbind(Date_hour,file1)

# select two first days of February 
twodays<-subset(file2, Date_hour>="2007-02-01 00:00:00" & Date_hour<"2007-02-03 00:00:00")
twodays$Global_active_power<-as.numeric(twodays$Global_active_power)

png(file="plot2.png",width = 480, height = 480)
plot(twodays$Date_hour, twodays$Global_active_power, main ="", type="l", ylab="Global Active Power (Kilowatts)", xlab="")
dev.off()