NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(plyr)
# Group and Sum the Emission data by year:
emissions_by_year<-aggregate(Emissions ~ year, data=NEI, sum)

# Plot PM2.5 Emission in Million Tons vs Year and save as plot1.png:
png("plot1.png")
barplot(emissions_by_year$Emissions/1000000, col="red", 
        names.arg=emissions_by_year$year, 
        main=bquote("Total "~PM[2.5]~" Emissions in the US per year"),
        xlab="Year", ylab="Million Tons")
dev.off()