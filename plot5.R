library(plyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI_Baltimore<-NEI[NEI$fips==24510,]
# Baltimore_emissions_by_year<-aggregate(Emissions ~ year,data=NEI_Baltimore, sum)


x<-table(SCC$EI.Sector)
y<-names(x)



match_mobile<-grep("mobile", tolower(y))
match_mobile_road<-grep("road", tolower(y[match_mobile]))

tmp1<-SCC[SCC$EI.Sector==y[match_mobile[match_mobile_road][1]],]
tmp2<-SCC[SCC$EI.Sector==y[match_mobile[match_mobile_road][2]],]
tmp3<-SCC[SCC$EI.Sector==y[match_mobile[match_mobile_road][3]],]
tmp4<-SCC[SCC$EI.Sector==y[match_mobile[match_mobile_road][4]],]
tmp5<-SCC[SCC$EI.Sector==y[match_mobile[match_mobile_road][5]],]
tmp6<-SCC[SCC$EI.Sector==y[match_mobile[match_mobile_road][6]],]

scc_mobile_road_df<-rbind(tmp1,tmp2,tmp3, tmp3, tmp4, tmp5, tmp6)

# Gather the scc codes:
motor_vehicle_scc<-as.character(scc_mobile_road_df$SCC)

# Subset only the coal-related stuff:
NEI_motor_vehicle_Baltimore<-
  NEI_Baltimore[NEI_Baltimore$SCC %in% motor_vehicle_scc,]


emissions_motor_vehicle_baltimore_by_year<-
  aggregate(Emissions ~ year, data=NEI_motor_vehicle_Baltimore, sum)

#png("plot5.png")
barplot(emissions_motor_vehicle_baltimore_by_year$Emissions/1000, col="red", 
        names.arg=emissions_motor_vehicle_baltimore_by_year$year, 
        main=bquote(
          "Total "~PM[2.5]~" Emissions from Motor Vehicles in Baltimore per year"),
        xlab="Year", ylab="Kilotons")
#dev.off()