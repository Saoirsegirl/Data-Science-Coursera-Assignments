library(dplyr)
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## emissions in baltimore from motor vehicle sources
emissions.in.Baltimore.by.motor <- NEI %>% filter(fips=="24510") %>% 
  filter(type == "ON-ROAD") %>% group_by(year) %>% summarise(total.emissions = sum(Emissions))

png(filename='plot5.png', width=800, height=500, units='px')
## Create plot
g <- ggplot(emissions.in.Baltimore.by.motor, aes(year, total.emissions)) + geom_bar(stat="identity") + ggtitle("PM 2.5 Motor Vehicle Emissions for Baltimore 1999-2008")

print(g)

dev.off()