# Impact of Severe Weather Events on Public Health and Economy
Dhruv Mishra  
Wednesday, March 18, 2015  

## Synopsis
The U.S. National Oceanic and Atmospheric Administration's (NOAA) storm database tracks characteristics of major storms and weather events in the United States. The events in the database start in the year 1950 and end in November 2011.

This report explores this database to find out the weather phenomena which have the most severe impact on public health and economy.

In particular the following two questions, the following two questions are addressed:

1. Across the United States, which types of events are most harmful with respect to population health?

2. Across the United States, which types of events have the greatest economic consequences?

One can download the database from [Storm Data](https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2). And also [Storm Data Documentation](https://d396qusza40orc.cloudfront.net/repdata%2Fpeer2_doc%2Fpd01016005curr.pdf) and [FAQ](https://d396qusza40orc.cloudfront.net/repdata%2Fpeer2_doc%2FNCDC%20Storm%20Events-FAQ%20Page.pdf).

## Loading and Processing the Raw Data

```r
library(grid)
library(dplyr)
library(ggplot2)
```
## Data Processing
The data was downloaded on local computer from the urls mentioned above and saved in the current working directory. The data is loaded from the csv file into the memory.

```r
NOAA <- read.csv("repdata-data-StormData.csv", head= TRUE)
```

#### Across the United States, which types of events (as indicated in the EVTYPE variable) are most harmful with respect to population health?
To answer this question, let's create the relevant subset data. This can be done by grouping the NOAA data frame by event type and then computing the sum of all the fatalities and injuries reported. The records where the sum for either column is zero can be filtered out.

For the purpose of finding maximum injuries and fatalities, the summary data can still further be filtered to contain only the top 5 records when sorted in decreasing order for each column.


```r
## get data where fatalities and injures are greater than 0.
pop.health <- NOAA %>% group_by(EVTYPE) %>% summarise(total.fatalities = sum(FATALITIES), total.injuries = sum(INJURIES))%>% filter(total.fatalities >0 | total.injuries >0)

## top 5

g.fatality <- ggplot((pop.health%>% arrange(desc(total.fatalities)))[1:5, ], aes(EVTYPE, total.fatalities)) + 
  geom_bar(stat="identity") +
  xlab("Type of Event") +
  ylab("Total Fatalities") +
  ggtitle("Fatalaties")

g.injury <- ggplot((pop.health%>% arrange(desc(total.injuries)))[1:5, ], aes(EVTYPE, total.injuries)) + 
  geom_bar(stat="identity") +
  xlab("Type of Event") +
  ylab("Total Injuries") +
  ggtitle("Injuries")
```

#### Across the United States, which types of events have the greatest economic consequences?
The NOAA data frame has two columns PROPDMGEXP and CROPDMGEXP which contain the exponents. The notation used for this data varies significantly (probably because different people handled the database during different times as the time frame is quite large.)
The following function is used to calculate the actual value by multiplying the PROPDMG/CROPDMG (denote by val variable) by the appropriate value of PROPDMGEXP/CROPDMGEXP (denoted by exp variable). The returned numerical value is what we are interested in. The funtion uses byte code for faster execution.


```r
## Exp values from "How To Handle Exponent Value of PROPDMGEXP and CROPDMGEXP"  [https://rpubs.com/flyingdisc/PROPDMGEXP](https://rpubs.com/flyingdisc/PROPDMGEXP).
total<-function(val,exp){
  
  if (is.na(val)) return(0)
  
  if (is.na(exp)) return(val)
  
  ##H,h = hundreds = 100
  if (exp=="H" | exp=="h") return(val*100)
  
  ##K,k = kilos = thousands = 1,000
  if (exp=="K" | exp=="k") return(val*1000)
  
  ##M,m = millions = 1,000,000
  if (exp=="M" | exp=="m") return(val*1000000)
  
  ##B,b = billions = 1,000,000,000
  if (exp=="B" | exp=="b") return(val*1000000000)

  ##(+) = 1
  ##numeric 0..8 = 10
  if (exp %in% c("+","0","1","2","3","4","5","6","7","8")) return(val*10)

  
  ##(-) = 0
  ##(?) = 0
  ##black/empty character = 0
  
  if (exp %in% c("-","","?")) return(val*1)
}

## speed up by using byte code.
require(compiler)
```

```
## Loading required package: compiler
```

```r
total_c<-cmpfun(total)
```

Using the total_c function, let's create the relevant subset. The DMG data frame contains addtional columns CROPDMGTOT and PROPDMGTOT containing the total values. The summary data can then be computed by first grouping on event type and then adding the PROPDMGTOT and CROPDMGTOT columns and filtering out the rows where the sum is zero.

For finding max values, the damages dataframe can further be filtered to contain only the top 5 records when sorted in decreasing order for each column. 

```r
## get data where fatalities and injures are greater than 0.
DMG <- NOAA %>% select(EVTYPE, PROPDMG, PROPDMGEXP, CROPDMG, CROPDMGEXP)

## calculate prop dmg total.
DMG <- DMG %>% mutate(PROPDMGTOT = total_c(PROPDMG, PROPDMGEXP))

## calculate crop dmg total.
DMG <- DMG %>% mutate(CROPDMGTOT = total_c(CROPDMG, CROPDMGEXP))

## Compute total property and crop damages for each event type.
damages <- DMG %>% group_by(EVTYPE) %>% summarise(total.prop.dmg = sum(PROPDMGTOT), total.crop.dmg = sum(CROPDMGTOT))%>% filter(total.prop.dmg >0 | total.crop.dmg >0)

## plot for top 5 separately

g.prop <- ggplot((damages%>% arrange(desc(total.prop.dmg)))[1:5, ], aes(EVTYPE, total.prop.dmg)) + 
  geom_bar(stat="identity") +
  xlab("Type of Event") +
  ylab("Total Property Damaged") +
  ggtitle("Property Damages")

## max is tornado

g.crop <- ggplot((damages%>% arrange(desc(total.crop.dmg)))[1:5, ], aes(EVTYPE, total.crop.dmg)) + 
  geom_bar(stat="identity") +
  xlab("Type of Event") +
  ylab("Total Crop Damaged") +
  ggtitle("Crop Damages")
```

The total damage caused to crop and property can also be recorded in an additional column total.dmg

```r
damages <- damages %>% mutate(total.dmg = total.prop.dmg + total.crop.dmg)
```

## Results
### Across the United States, which types of events (as indicated in the EVTYPE variable) are most harmful with respect to population health?

```r
pushViewport(viewport(layout = grid.layout(2, 1)))
print(g.fatality, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(g.injury, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
```

![](rep-data-peer-assignment2_files/figure-html/unnamed-chunk-7-1.png) 


As can be seen in both cases, maximum injuries and fatalities are caused by **tornado**.

### Across the United States, which types of events have the greatest economic consequences?

```r
pushViewport(viewport(layout = grid.layout(2, 1)))
print(g.prop, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
print(g.crop, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
```

![](rep-data-peer-assignment2_files/figure-html/unnamed-chunk-8-1.png) 


As can be seen from the above plot, maximum property damage is caused by *tornado* while maximum crop damage is caused by *hail*.


```r
g.total.dmg <- ggplot((damages%>% arrange(desc(total.dmg)))[1:5, ], aes(EVTYPE, total.crop.dmg)) + 
  geom_bar(stat="identity") +
  xlab("Type of Event") +
  ylab("Total Damages") +
  ggtitle("Total Damages")
print(g.total.dmg)
```

![](rep-data-peer-assignment2_files/figure-html/unnamed-chunk-9-1.png) 


However on an aggregate basis (both property and crop damage combined), the top two event types **flood** and **flash flood** (which for all practical purposes can be considered as a single event type) have my maximum economic consequences.
