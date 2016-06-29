# plot2 shows the total emission of PM25 for Baltimore city ( fips=="24510")

SCC<-readRDS(file="Source_Classification_Code.rds")
NEI<-readRDS(file="summarySCC_PM25.rds")
library(dplyr)

#filter the data for Baltimore only
Baltimore<-filter(NEI, fips=="24510")
years<-factor(Baltimore$year)
totals<- sapply(split(Baltimore$Emissions,years), sum, na.rm=TRUE, simplify=FALSE)
df<-data.frame(totals)
colnames(df)<-sub("X","", colnames(df))

#create the png file
png(filename="Plot2.png", width=600, height=600 )
par(mfrow=c(1,1), mar= c(4,4,3,1))
plot(colnames(df),df[1,], type="b",xlab="Year", ylab="PM2.5 emissions in tons", main=" Total emissions of PM2.5 in Baltimore from 1999 to 2008 " , col="red",lwd=4)


#return to the screen device
dev.off()
dev.set(which = 2)
