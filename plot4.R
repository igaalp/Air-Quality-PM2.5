# plot4 shows the total emission of coal-related PM25 in all USA 

SCC<-readRDS(file="Source_Classification_Code.rds")
NEI<-readRDS(file="summarySCC_PM25.rds")
library(dplyr)
library(ggplot2)

#Select only coal related Short.Name 
SCCcoal<-tbl_df(SCC)
SCCcoal<-select(SCCcoal, SCC, Short.Name)
SCCcoalfiltered<-SCCcoal[grep("Coal", SCCcoal$Short.Name),]

#filter only SCC related to coal
NEIcoal<-NEI[NEI$SCC %in% SCCcoalfiltered$SCC,]
NEIcoal<-tbl_df(NEIcoal)
NEIcoalgroup<-group_by(NEIcoal, year)
NEIcoalsum<-summarise(NEIcoalgroup,Emissions=sum(Emissions))


#create the png file
png(filename="Plot4.png", width=600, height=600 )
par(mfrow=c(1,1), mar= c(4,4,4,1))
plot(NEIcoalsum$year,NEIcoalsum$Emissions, type="b",xlab="Year", ylab="PM2.5 coal related emissions in tons", main=" Total coal-related emissions of PM2.5 in the United States from 1999 to 2008 " , col="red", lwd=3)


#return to the screen device
dev.off()
dev.set(which = 2)
