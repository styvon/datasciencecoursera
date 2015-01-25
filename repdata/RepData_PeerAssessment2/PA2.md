# Exploring Influence of Weather Events on Population Health and Economy Using NOAA Storm Database
Yvonne Zhuang  
  
**Synopsis:** This article takes a brief look into the weather influences on population health and economy accross the United States from 1950 to 2011 using the NOAA storm data. *Data Processing* Data is processed so that for each type of weather event, its health influence is estimated by total fatalities and injuries, and  economic consequence by total property and crop damage. *Results* 20 weather events causing the largest health and economic loss are listed respectively. For population health outcomes, tornados take first place of the list, causing a total of 96,979 people dead or injured across the country, followed by excessive heats (8,428), thunderstorm winds (7,461), floods (7,259) and lightnings (6,046). For economic loss, floods take first place of the list, causing a total of $150.3 billion USD loss across the country, followed by hurricane/typhoon ($71.9 billion USD), tornados ($57.4 billion USD), storm surges ($43.3 billion USD) and hails ($18.8 billion USD). *Discussion* Further analysis is to be conducted to investigate the characteristics of weather influences.
  
    
    
## Data Processing
1. The NOAA storm database raw data is retrieved from [here](https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2) and loaded into R. (the *readRDS* command line is used for fast reading if the object is already in the local directory.)

```r
if(!file.exists("raw.RDS")) {
  url <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
  download.file(url, "StormData.csv.bz2", method = "curl")
  raw <- read.table(file = "StormData.csv.bz2", header = T, sep = ",")
}
raw <- readRDS("raw.RDS")
```
  
  
2. Include variables that indicate: 1) types of events, 2) total number of fatalities for each event, 3) total number of injuries for each event, 4) total property damages for each event, 5) total crop damage for each event, 6) total economic damage, into a new data set.

```r
library(dplyr, quietly= T)
```

```
## 
## Attaching package: 'dplyr'
## 
## The following object is masked from 'package:stats':
## 
##     filter
## 
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
df <- select(raw, EVTYPE, FATALITIES:CROPDMGEXP) 
```
  
  
3. Create a function that replace original elements (*ori*) in *x* with new values (*rep*).

```r
cleanexp <- function(ori,rep,x) {
  output <- x
  for (i in 1:length(ori)) {
    for (j in seq_along(x)) {
      if (x[j] == ori[i]) {
        output[j] <- rep[i]
        }
      }
    }
  output
}
```
  
  
4. Substitute keys in PROPDMGEXP/CROPDMGEXP variables with values. Keys and values are listed in *Table 1*. 

```r
orig <-unique(c(as.character(unique(df$PROPDMGEXP)),as.character(unique(df$CROPDMGEXP))))
repl <- c(10^3,10^6,1,10^9,10^6,1,1,10^5,10^6,1,10^4,10^2,10^3,10^2,10^7,10^2,1,10,10^8,10^3)
df$PROPDMGEXP <- as.numeric(cleanexp(orig, repl, as.character(df$PROPDMGEXP)))
df$CROPDMGEXP <- as.numeric(cleanexp(orig, repl, as.character(df$CROPDMGEXP)))
library(xtable, quietly= T)
table <- xtable(rbind(orig,repl))
print(table, type = "html")
```

<!-- html table generated in R 3.1.2 by xtable 1.7-4 package -->
<!-- Sun Jan 25 11:03:14 2015 -->
<table border=1>
<tr> <th>  </th> <th> 1 </th> <th> 2 </th> <th> 3 </th> <th> 4 </th> <th> 5 </th> <th> 6 </th> <th> 7 </th> <th> 8 </th> <th> 9 </th> <th> 10 </th> <th> 11 </th> <th> 12 </th> <th> 13 </th> <th> 14 </th> <th> 15 </th> <th> 16 </th> <th> 17 </th> <th> 18 </th> <th> 19 </th> <th> 20 </th>  </tr>
  <tr> <td align="right"> orig </td> <td> K </td> <td> M </td> <td>  </td> <td> B </td> <td> m </td> <td> + </td> <td> 0 </td> <td> 5 </td> <td> 6 </td> <td> ? </td> <td> 4 </td> <td> 2 </td> <td> 3 </td> <td> h </td> <td> 7 </td> <td> H </td> <td> - </td> <td> 1 </td> <td> 8 </td> <td> k </td> </tr>
  <tr> <td align="right"> repl </td> <td> 1000 </td> <td> 1e+06 </td> <td> 1 </td> <td> 1e+09 </td> <td> 1e+06 </td> <td> 1 </td> <td> 1 </td> <td> 1e+05 </td> <td> 1e+06 </td> <td> 1 </td> <td> 10000 </td> <td> 100 </td> <td> 1000 </td> <td> 100 </td> <td> 1e+07 </td> <td> 100 </td> <td> 1 </td> <td> 10 </td> <td> 1e+08 </td> <td> 1000 </td> </tr>
   </table>
Table 1. Original keys in variables PROPDMGEXP and CROPDMGEXP and the corresponding replacement values. 
  
  
5. Further data processing include: 1) calculating overall influence on population health, 2) calculating property damage and crop damage, 4) calculating overall economic loss, 5) unifying units of economic loss ($Million USD), 6) unifying variable names. Each numeric value in the processed data set represents the total number for each type of weather event.

```r
df <-
group_by(df, EVTYPE) %>%
mutate(HEALTH = FATALITIES + INJURIES, EPROP = PROPDMG * PROPDMGEXP/10^6, ECROP = CROPDMG * CROPDMGEXP/10^6, ECO = EPROP + ECROP) %>%
summarize(fatalities = sum(FATALITIES), injuries = sum(INJURIES), health = sum(HEALTH), eprop = sum(EPROP), ecrop = sum(ECROP), eco = sum(ECO)) 
names(df) <- tolower(names(df))
```

6. Gather variables in *df* and form a new data set (*hdata*) for evaluating influence on population health. 

```r
library(tidyr, quietly= T)
hdata <- gather(df[,-(4:7)], outcome, num, -evtype)
hdata$health <- rep(df$health,2)
```
Listed below are variables in *hdata* :
- evtype: types of event (evtype),
- outcome: types of health outcome (fatality/injury),
- num: number of people inflicted, and
- health: total number of fatality and injury for each event (health).

7. Gather variables in *df* and form a new data set (*edata*) for evaluating economic loss.

```r
edata <- gather(df[,c(1,5:6)], group, damage, -evtype)
edata$eco <- rep(df$eco,2)
```
  

## Results
### Exploring health outcomes
1. *Figure 1* is a stacked bar plot with types of events as y axis and health consequenses as x axis, types of events are ordered by total number of fatalities and injuries. Only the top 20 events are plotted.

```r
library(ggplot2, quietly= T)
htop <- df$evtype[which(rank(df$health) %in% 966:985)]
hdata2 <- hdata[hdata$evtype %in% htop,]
for (i in 1:nrow(hdata2)) {
  if (hdata2$outcome[i] =="fatalities"){
    hdata2$num[i] <- -hdata2$num[i]
  }
}
gh <- ggplot(hdata2, aes(x = reorder(evtype,health), y = num, fill = outcome))
gh + geom_bar(stat = "identity", position = "identity", width = 0.5) + 
     coord_flip() +
     xlab("Weather Events") +
     ylab("Number") +
     theme(legend.position="top") +
     ggtitle("Figure 1: Top 20 Weather Events  with Highest Fatalities & Injuries")
```

![](PA2_files/figure-html/unnamed-chunk-2-1.png) 

```r
hrank <- arrange(hdata2, desc(health))
unique(hrank[,c(1,4)])
```

```
## Source: local data frame [20 x 2]
## 
##                evtype health
## 1             TORNADO  96979
## 2      EXCESSIVE HEAT   8428
## 3           TSTM WIND   7461
## 4               FLOOD   7259
## 5           LIGHTNING   6046
## 6                HEAT   3037
## 7         FLASH FLOOD   2755
## 8           ICE STORM   2064
## 9   THUNDERSTORM WIND   1621
## 10       WINTER STORM   1527
## 11          HIGH WIND   1385
## 12               HAIL   1376
## 13  HURRICANE/TYPHOON   1339
## 14         HEAVY SNOW   1148
## 15           WILDFIRE    986
## 16 THUNDERSTORM WINDS    972
## 17           BLIZZARD    906
## 18                FOG    796
## 19        RIP CURRENT    600
## 20   WILD/FOREST FIRE    557
```

Tornados take first place of the list, causing a total of 96,979 people dead or injured across the country, followed by excessive heats (8,428), thunderstorm winds (7,461), floods (7,259) and lightnings (6,046). 
 
### Exploring economic consequences
*Figure 2* is a bar plot with types of events as y axis and economic consequenses as x axis. Only the top 20 events are plotted.

```r
etop <- df$evtype[which(rank(df$eco) %in% 966:985)]
edata2 <- edata[edata$evtype %in% etop,]
for (i in 1:nrow(edata2)) {
  if (edata2$group[i] =="ecrop"){
    edata2$damage[i] <- -edata2$damage[i]
  }
}
ge <- ggplot(edata2, aes(x=reorder(evtype,eco), y=damage, fill=group))
ge + geom_bar(stat = "identity", position = "identity", width = 0.5) + 
     coord_flip() +
     xlab("Weather Events") +
     ylab("Economic Loss ($M USD)") +
     theme(legend.position="top") +
     ggtitle("Figure 2: Top 20 Weather Events  Causing Largest Economic Loss")
```

![](PA2_files/figure-html/unnamed-chunk-3-1.png) 

```r
erank <- arrange(edata2, desc(eco))
unique(erank[,c(1,4)])
```

```
## Source: local data frame [20 x 2]
## 
##                       evtype        eco
## 1                      FLOOD 150319.678
## 2          HURRICANE/TYPHOON  71913.713
## 3                    TORNADO  57362.334
## 4                STORM SURGE  43323.541
## 5                       HAIL  18761.222
## 6                FLASH FLOOD  18243.991
## 7                    DROUGHT  15018.672
## 8                  HURRICANE  14610.229
## 9                RIVER FLOOD  10148.405
## 10                 ICE STORM   8967.041
## 11            TROPICAL STORM   8382.237
## 12              WINTER STORM   6715.441
## 13                 HIGH WIND   5908.618
## 14                  WILDFIRE   5060.587
## 15                 TSTM WIND   5038.936
## 16          STORM SURGE/TIDE   4642.038
## 17         THUNDERSTORM WIND   3897.966
## 18            HURRICANE OPAL   3191.846
## 19          WILD/FOREST FIRE   3108.626
## 20 HEAVY RAIN/SEVERE WEATHER   2500.000
```

Floods take first place of the list, causing a total of $150.3 billion USD loss across the country, followed by hurricane/typhoon ($71.9 billion USD), tornados ($57.4 billion USD), storm surges ($43.3 billion USD) and hails ($18.8 billion USD).  

  
## Discussion
1. As can be seen from *Figure 2*, damages to properties and crops are not evenly distributed. For example, while drought ranks sixth in total economic loss, it causes the largest crop damage of all weather events. 
2. Considering the complexity of the data, more characteristics can be extracted with further analysis conducted, including the change of weather influence across time, average damage caused by a single weather event etc.
