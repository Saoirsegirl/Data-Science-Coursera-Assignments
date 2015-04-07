library(dplyr)
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## emissions in baltimore from motor vehicle sources
emissions.by.motor <- NEI %>% filter(fips=="24510" | fips=="06037") %>% 
  filter(type == "ON-ROAD") %>% group_by(fips, year) %>% summarise(total.emissions = sum(Emissions))

## Add city names
emissions.by.motor.Bal <- emissions.by.motor[emissions.by.motor$fips=="24510",]
emissions.by.motor.LA <- emissions.by.motor[emissions.by.motor$fips=="06037",]
emissions.by.motor.LA$city <- "Los Angeles County"
emissions.by.motor.Bal$city <- "Baltimore City"
emissions.by.motor <- rbind(emissions.by.motor.Bal, emissions.by.motor.LA)

## Create plot
png(filename='plot6.png', width=800, height=500, units='px')

g <- ggplot(emissions.by.motor, aes(year, total.emissions)) + geom_bar(stat="identity") + facet_grid(.~city) + ggtitle("PM 2.5 Motor Vehicle Emissions for Baltimore and LA 1999-2008")

print(g)
dev.off()