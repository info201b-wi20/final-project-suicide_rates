library(shiny)

source("gdp_server.R")
source("gdp_ui.R")

shinyApp(ui = ui, server = server)