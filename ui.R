
library(shiny)

shinyUI(pageWithSidebar(
     headerPanel('Grand Canyon Colorado River Flow'),
     sidebarPanel(
          checkboxInput('leesplot', 'Plot Lees Ferry Flow', value = TRUE),
          checkboxInput('phanplot', 'Plot Phantom Ranch Flow', value = TRUE),
          checkboxInput('diacrplot', 'Plot Diamond Creek Flow', value = TRUE),
          numericInput('days', 'Calculate Stats Last X days', 3, min = 1, max = 6),
          h2("Data Source"),
          p("All data is of the Colorado river flow in the Grand Canyon from the USGS. The data is made available from waterdata.usgs.gov"),
          p("The specific river gauge pages of interest are:"),
          code("http://waterdata.usgs.gov/nwis/inventory?agency_code=USGS&site_no=09380000, http://waterdata.usgs.gov/nwis/inventory?agency_code=USGS&site_no=09402500, http://waterdata.usgs.gov/nwis/inventory?agency_code=USGS&site_no=09404200"),
          h2("Instructions"),
          p("1) Select the plots of the certain river gauges that you want to display"),
          p("2) Select the number of days from today to calculate the summary statistics"),
          h2("Calculations"),
          p("Summary statisticals are calculated for all three river gauges from the most recent data to X number of days ago, where the user selects the value of X days")
     ),
     mainPanel(
          plotOutput('plot1'),
          dataTableOutput('summarytab')
     )
))
