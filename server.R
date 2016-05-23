
library(shiny)
library(dplyr)

shinyServer(function(input, output, session) {
     
     
     # set urls where data is
     url.lees <- "http://waterdata.usgs.gov/nwis/uv?cb_00060=on&cb_00065=on&format=rdb&site_no=09380000&period=7&begin_date=&end_date="
     url.diacr <- "http://waterdata.usgs.gov/nwis/uv?cb_00060=on&cb_00065=on&format=rdb&site_no=09404200&period=7&begin_date=&end_date="
     url.phan <- "http://waterdata.usgs.gov/nwis/uv?cb_00060=on&cb_00065=on&format=rdb&site_no=09402500&period=7&begin_date=2016-05-16&end_date=2016-05-23"
     
     #Read data
     colClasses <- c("NULL", "NULL", "POSIXct", "NULL", "numeric", "NULL", "numeric", "NULL")
     leesdata <- read.table(url.lees, header = FALSE, sep = "\t", skip = 27, colClasses = colClasses)
     diacrdata <- read.table(url.diacr, header = FALSE, sep = "\t", skip = 27, colClasses = colClasses)
     phandata <- read.table(url.phan, header = FALSE, sep = "\t", skip = 27, colClasses = colClasses)
     rm(url.phan,url.diacr,url.lees)
     
     #Set column names
     names(leesdata) <- c("date.time", "lees.discharge.cfs", "lees.gaugeht.ft")
     names(diacrdata) <- c("date.time", "diacr.discharge.cfs", "diacr.gaugeht.ft")
     names(phandata) <- c("date.time", "phan.discharge.cfs", "phan.gaugeht.ft")
     
     # Only use rows where we have data from all sites
     rows <- min(nrow(leesdata), nrow(diacrdata), nrow(phandata))
     leesdata <- leesdata[1:rows,]
     diacrdata <- diacrdata[1:rows,]
     phandata <- phandata[1:rows,]
     
     # Combine into one data frame
     gc.data <- cbind(leesdata, phandata[,2:3], diacrdata[,2:3])
     
     # Clean up variables that are not needed
     rm(diacrdata, leesdata, phandata, rows, colClasses)
     
     #Create summary table data
     #summarytable <- summary(gc.data[seq(from=nrow(gc.data)-3*4*24, to=nrow(gc.data)),c(2,4,6)])
     #reactive({
     #     rangeofdatapoints <- seq(from=nrow(gc.data)-input$days*4*24, to=nrow(gc.data))
     #     summarytable <- summary(gc.data[rangeofdatapoints,c(2,4,6)])
     #     output$summarytab <- renderDataTable({ summarytable })
     #})
     
     output$summarytab <- renderDataTable({
          rangeofdatapoints <- seq(from=nrow(gc.data)-input$days*4*24, to=nrow(gc.data))
          summarytable <- summary(gc.data[rangeofdatapoints,c(2,4,6)])
          summarytable
     })
     
     
     
     output$plot1 <- renderPlot({
          
          plot(x = gc.data$date.time, y = gc.data$lees.discharge.cfs, type = "n", 
               main="Grand Canyon Colorado River Flow", 
               xlab="Date", ylab="River Flow-cfs")
          
          if (input$leesplot) lines(x = gc.data$date.time, y = gc.data$lees.discharge.cfs, type = "l", col="blue", lwd=2)
          if (input$phanplot) lines(x = gc.data$date.time, y = gc.data$phan.discharge.cfs, type = "l", col="red", lwd=2)
          if (input$diacrplot) lines(x = gc.data$date.time, y = gc.data$diacr.discharge.cfs, type = "l", col="green", lwd=2)
          
          legend("bottom", c("Lees", "Phantom", "Diamond"), lty=c(1,1,1), lwd=c(3,3,3), col=c("blue","red","green"))
          
     })
     
     
     
     
     
})