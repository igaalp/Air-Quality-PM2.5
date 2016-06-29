# plot1 show the total emission of PM25 for the whole country USA

SCC<-readRDS(file="Source_Classification_Code.rds")
NEI<-readRDS(file="summarySCC_PM25.rds")

library(dplyr)

#group and sum by year

df<-tbl_df(NEI)
df<-select(df, year, Emissions)
grpyear<-group_by(df, year)
NEIyear<-summarise(df,  Emissions=sum(Emissions))

#create the png file
png(filename="Plot1.png", width=600, height=600 )
par(mfrow=c(1,1), mar= c(4,4,3,1))
plot(x=NEIyear$year, y=NEIyear$Emissions, type="b",xlab="Year", ylab="PM2.5 emissions in tons", main=" Total emissions of PM2.5 in the United States from 1999 to 2008 " , col="blue", lwd=4)


#return to the screen device
dev.off()
dev.set(which = 2)
