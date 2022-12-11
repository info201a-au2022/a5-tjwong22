#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

introTab <- tabPanel(
  "Introduction",
  titlePanel("Introduction"),
  mainPanel (
    p("mini intro to intro"),
    h1("value of interest 1"),
    p(""),
    h1("value of interest 2"),
    p(""),
    h1("value of interest 3"),
    p(""),
    p("outro to intro")
  )
)

# Define UI for application that draws a histogram
ui <- shinyUI(navbarPage(
  introTab
  # interactive_tab
))
