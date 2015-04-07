library(dplyr)
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## group data based on type and year
emissions.by.type <- NEI%>%group_by(year, type)%>%summarise(total.emissions =sum(Emissions))

png(filename='plot3.png', width=800, height=500, units='px')

g <- ggplot(emissions.by.type, aes(year, total.emissions)) + geom_bar(stat="identity") + facet_grid(.~type, scales = "free",space="free") + ggtitle("PM 2.5 Emissions for Baltimore 1999-2008")

print(g)

dev.off()