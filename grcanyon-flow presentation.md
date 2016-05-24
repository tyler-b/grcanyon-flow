grcanyon-flow Application
========================================================
author: Tyler Brown
date: May 23, 2016
autosize: true

Motivation
========================================================

River flows in the grand canyon are important for ecological, recreational, and public safety issues. The main river in the grand canyon is the Colorado River. The United States Geological Survey (USGS) provides river flow data in near real-time. This data can be used to answer questions like these:

- Have river flows changed drastically over the recent days which could indicate damage to ecological sites?
- Is the river flow at an acceptable level to launch a rafting party?
- What is the usual day/nigh flow oscillation recently?

How Data is gathered
========================================================




```r
colClasses <- c("NULL", "NULL", "POSIXct", "NULL", "numeric", "NULL", "numeric", "NULL")
leesdata <- read.table(url.lees, header = FALSE, sep = "\t", skip = 27, colClasses = colClasses)
names(leesdata) <- c("date.time", "lees.discharge.cfs", "lees.gaugeht.ft")
head(leesdata)
```

```
            date.time lees.discharge.cfs lees.gaugeht.ft
1 2016-05-16 00:00:00              12300            9.13
2 2016-05-16 00:15:00              12100            9.09
3 2016-05-16 00:30:00              11800            9.03
4 2016-05-16 00:45:00              11600            8.99
5 2016-05-16 01:00:00              11400            8.93
6 2016-05-16 01:15:00              11100            8.87
```

How Data is Plotted
========================================================



![plot of chunk unnamed-chunk-4](grcanyon-flow presentation-figure/unnamed-chunk-4-1.png)


Results
========================================================

* Faster visualization of real-time data
* Better Decision making
* More fun on the River!
