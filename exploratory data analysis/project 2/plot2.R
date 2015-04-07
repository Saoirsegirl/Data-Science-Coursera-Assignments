library(dplyr)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Calculate emissions in Baltimore City (fips=="24510")
emissions.in.Baltimore <- NEI %>% filter(fips=="24510") %>% 
  group_by(year)%>%summarise(total.emissions = sum(Emissions))

## Create plot
png('plot2.png')
plot(emissions.in.Baltimore$year, emissions.in.Baltimore$total.emissions, xlab = "Year", ylab = "PM 2.5 Emissions", type="l", main = "PM 2.5 Emissions in Baltimore City")

dev.off()

## emissions are down overall