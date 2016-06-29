# plot3 shows the total emission of PM25 for Baltimore city ( fips=="24510") by type 

SCC<-readRDS(file="Source_Classification_Code.rds")
NEI<-readRDS(file="summarySCC_PM25.rds")
library(dplyr)
library(ggplot2)

#filter the data for Baltimore only
Baltimore<-filter(NEI, fips=="24510")
Baltimoredf<-tbl_df(Baltimore)
Baltimoredfgrouped<-group_by(Baltimoredf,year, type)
Baltimoresum<-summarise(Baltimoredfgrouped, Emissions=sum(Emissions))

#create the png file
png(filename="Plot3.png", width=600, height=600 )

qplot(year,Emissions, data=Baltimoresum, color=type, geom="line", main="Baltimore Emisions of PM2.5 by type, from year 1999 to 2008", ylab="Emissions of PM2.5 (tons)")


#return to the screen device
dev.off()
dev.set(which = 2)
