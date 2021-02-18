library(shiny)
library(shinydashboard)
library(DT)
library(ggplot2)
library(rhandsontable)


source("ui_main.R")
server <- function(input, output, session) {
  
  
  
  source("server_datatable.R", local = T)
  source("server_bettb.R", local = T)
  source("server_smrtb.R", local = T)
  source("server_smr.R", local = T)
  source("server_intplot.R", local = T)
  source("server_download.R", local = T)
}

shinyApp(ui, server)





