NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(plyr)
library(ggplot2)
# Group and Sum the Emission data by year:
NEI_Baltimore<-NEI[NEI$fips==24510,]
Baltimore_emissions_by_year<-aggregate(Emissions ~ year + type,
                                       data=NEI_Baltimore, sum)

png("plot3.png")
c <- ggplot(Baltimore_emissions_by_year, aes(x=factor(year), 
                                             y=Emissions, fill=type))
c + geom_bar(stat="identity", 
             position=position_dodge(), 
             color="black") + 
  labs(title=bquote("Total "~PM[2.5]~
                      " Emissions in Baltimore per Year and Source."),
       x="Year", y="Emissions [Tons]")
dev.off()