library(plyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


x<-table(SCC$EI.Sector)
y<-names(x)
coal_vector<-grep("coal", tolower(y))
y<-y[coal_vector]
tmp1<-SCC[SCC$EI.Sector==y[1],]
tmp2<-SCC[SCC$EI.Sector==y[2],]
tmp3<-SCC[SCC$EI.Sector==y[3],]

scc_coal_df<-rbind(tmp1,tmp2,tmp3)

# Gather the scc codes:
coal_comb<-as.character(scc_coal_df$SCC)

# Subset only the coal-related stuff:
NEI_coal<-NEI[NEI$SCC %in% coal_comb,]


coal_emissions_by_year<-aggregate(Emissions ~ year, data=NEI_coal, sum)

png("plot4.png")
barplot(coal_emissions_by_year$Emissions/1000, col="red", 
        names.arg=coal_emissions_by_year$year, 
        main=bquote("Total "~PM[2.5]~" Emissions in the US from Coal Combustion per year"),
        xlab="Year", ylab="Kilotons")
dev.off()
