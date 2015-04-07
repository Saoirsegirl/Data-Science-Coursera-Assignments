library(dplyr)
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## select coal combustion related sources.
coal.sources <- SCC %>% filter(grepl("Fuel Comb.*Coal", EI.Sector))

## filter rows from NEI based on coal related scc
emissions.from.coal <- NEI %>% filter(SCC %in% coal.sources$SCC)

## group by year
emissions.from.coal.by.year <- emissions.from.coal %>%group_by(year) %>% 
  summarise(total.emissions=sum(Emissions))

png(filename='plot4.png', width=800, height=500, units='px')

g <- ggplot(emissions.from.coal.by.year, aes(year, total.emissions)) + geom_bar(stat="identity") + ggtitle("PM 2.5 Coal Combustion 1999-2008")

print(g)
dev.off()


