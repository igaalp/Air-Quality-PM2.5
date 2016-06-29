# plot5 shows the total emission of PM25 for Baltimore city ( fips=="24510") for Vehicles only

#SCC<-readRDS(file="Source_Classification_Code.rds")
#NEI<-readRDS(file="summarySCC_PM25.rds")
library(dplyr)
library(ggplot2)

#Select only vehicle related SCC.Level.Two
SCCVehicle<-tbl_df(SCC)
SCCVehicle<-select(SCCVehicle, SCC, SCC.Level.Two)
SCCVehiclefiltered<-SCCVehicle[grep("Vehicle", SCC$SCC.Level.Two),]

#filter the data for Baltimore only

BaltimoreVehicle<-filter(NEI, fips=="24510" & SCC %in% SCCVehiclefiltered$SCC)
Baltimoredf<-tbl_df(BaltimoreVehicle)
Baltimoredfgrouped<-group_by(Baltimoredf,year)

Baltimoresum<-summarise(Baltimoredfgrouped, Emissions=sum(Emissions))

#create the png file
png(filename="Plot5.png", width=600, height=600 )

qplot(year,Emissions, data=Baltimoresum, geom="line", main="Baltimore Emisions of PM2.5 from Vehicles, from year 1999 to 2008", ylab="Emissions of PM2.5 (tons)")


#return to the screen device
dev.off()
dev.set(which = 2)
