# plot6 shows the total emission of PM25 for Baltimore city and Los Angeles( fips=="24510" and "06037") for Vehicles only

SCC<-readRDS(file="Source_Classification_Code.rds")
NEI<-readRDS(file="summarySCC_PM25.rds")
library(dplyr)
library(ggplot2)

#Select only vehicle related Scc.Level.Two 
SCCVehicle<-tbl_df(SCC)
SCCVehicle<-select(SCCVehicle, SCC, SCC.Level.Two)
SCCVehiclefiltered<-SCCVehicle[grep("Vehicle", SCC$SCC.Level.Two),]

#filter the data for Baltimore  and LA only

BaltLA<-filter(NEI, (fips=="24510" | fips=="06037") & SCC %in% SCCVehiclefiltered$SCC)
BaltLAcounty<-mutate(BaltLA, county=ifelse(fips=="24510", "Baltimore","Los Angeles"))
BaltLAcounty<-tbl_df(BaltLAcounty)
BaltLAgrouped<-group_by(BaltLAcounty,year, county)

BaltLAsum<-summarise(BaltLAgrouped, Emissions=sum(Emissions))

#create the png file
png(filename="Plot6.png", width=600, height=600 )

qplot(year,Emissions, data=BaltLAsum, geom="line", color=county, main="Baltimore and Los Angeles Emisions of PM2.5 from Vehicles, from year 1999 to 2008", ylab="Emissions of PM2.5 (tons)")


#return to the screen device
dev.off()
dev.set(which = 2)
