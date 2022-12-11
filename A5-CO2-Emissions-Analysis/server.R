#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)
library(tidyverse)
library(plotly)
library(rsconnect)

co2_data_with_countries <- read.csv("data/owid-co2-data.csv")
co2_data <- co2_data_with_countries %>%
  filter(iso_code != "")
countries <- unique(co2_data$country)

add_Z <- function(x, y, given_year){
  result <- co2_data %>%
    filter(country == x) %>%
    filter(year == given_year) %>%
    pull(y)
  return(result)
}


# Define server logic required to draw a bar plot
server <- shinyServer(function(input, output) {
    output$interactive <- renderPlotly({
      # filter to plottable dataset
      filtered_data <- co2_data %>%
        filter(year == input$year) %>%
        select(country, all_of(input$co2source)) %>%
        filter(country %in% input$country)
      
      plot_x <- input$country
      plot_y <- input$co2source
      plot_data <- expand.grid(X=plot_x, Y=plot_y)
      plot_data$Z <- mapply(add_Z, as.character(plot_data$X),
                            as.character(plot_data$Y), input$year)
      
      # makes interactive more readable (when hovering over values)
      Country <- plot_data$X
      Tons_per_Person <- plot_data$Z
      CO2_Emission_Type <- plot_data$Y
      
      # plots the chart
      interactive_chart <- ggplot(plot_data,
                                  aes(fill=CO2_Emission_Type,
                                      x=Country,
                                      y=Tons_per_Person)) +
        geom_bar(position="stack", stat="identity") +
        ggtitle(paste("Country CO2 Emissions in", input$year, "by Emission Type")) +
        ylab("Tons per Person")
    })

})
