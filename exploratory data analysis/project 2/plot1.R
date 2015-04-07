library(dplyr)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Assume that file is present in the same directory as this script

## calculate emmissions in each year
emissions.per.year <- NEI %>%group_by(year)%>%summarise(total.emissions=sum(Emissions))

## Create plot
png('plot1.png')
plot(emissions.per.year$year, emissions.per.year$total.emissions, xlab = "Year", ylab = "PM 2.5 Emissions", type="l", main = "Total Emissions of PM 2.5")

dev.off()


## The emmissions have decreased.