# plot1 show the total emission of PM25 for the whole country USA

SCC<-readRDS(file="Source_Classification_Code.rds")
NEI<-readRDS(file="summarySCC_PM25.rds")

#split and sum by year
years<-factor(NEI$year)
totals<- sapply(split(NEI$Emissions,years), sum, na.rm=TRUE, simplify=FALSE)
df<-data.frame(totals)
colnames(df)<-sub("X","", colnames(df))

#create the png file
png(filename="Plot1.png", width=600, height=600 )
par(mfrow=c(1,1), mar= c(4,4,3,1))
plot(colnames(df),df[1,], type="b",xlab="Year", ylab="PM2.5 emissions in tons", main=" Total emissions of PM2.5 in the United States from 1999 to 2008 " , col="blue", lwd=4)


#return to the screen device
dev.off()
dev.set(which = 2)
