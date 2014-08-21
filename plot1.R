NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(plyr)
emissions_by_year<-aggregate(Emissions ~ year, data=NEI, sum)
plot(emissions_by_year)
barplot(emissions_by_year$Emissions, col="red", 
        names.arg=emissions_by_year$year, 
        main=bquote("Total "~PM[2.5]~" Emissions in the US per year"))
