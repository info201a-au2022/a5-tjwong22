#Library
library(shiny)
library(ggplot2)
library(dplyr)
library(tidyverse)
library(plotly)
library(rsconnect)

#Sources
source("server.R")
source("ui.R")

#Connection
shinyApp(ui = ui, server = server)
