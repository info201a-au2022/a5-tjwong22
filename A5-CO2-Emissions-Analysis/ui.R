#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
source("server.R")

intro_tab <- tabPanel(
  "Introduction",
  titlePanel("Introduction"),
  mainPanel (
    p("CO2 emissions don’t only tell people how much a country produces and
      handles the emission, but it also can describe the state of a country
      based on what types of emissions they are producing and how much. This
      analysis of those CO2 emissions across the world will be able to present
      a variety of countries to see how they compare to one another and it will
      also be able to display a country so it can be seen throughout the years
      and show its history."),
    
    h3("Which production-based source of co2 emissions produces the most?"),
    p("Rather than finding a singular answer for which emission was the most
      common (but it's probably a mix of coal, gas, oil, and land use change
      right now), I found that there was a trend that happened for many
      developed and developing countries. That trend was a country would always
      start out with solely land use change CO2 emissions in their early years,
      but then coal would become more and more used to the point where it had
      equal emissions than land use change, or it was more. After that, oil
      would be more present, and later gas to the point where emissions by type
      would be more or less equal to one another but the initial land use change
      CO2 emissions would be either very small or gone completely."),
    
    h3("How has the U.S. CO2 emissions changed over the years?"),
    p("In 1850, the U.S. followed the trend of any other country with high CO2
      emissions stemming from land use change and totaling emissions to about
      35 tons per capita. The decade following, total CO2 emissions began to
      fall to under 30 tons per capita as land use change emissions fell, while
      coal emissions became more popular and oil started to rise. Today, U.S.
      CO2 emissions total to 15 tons per capita where oil, gas, and coal are the
      predominant emissions but almost equally. Oil has CO2 emissions of 6.6
      tons per capita, gas has CO2 emissions of 4.8 tons per capita, coal has
      CO2 emissions of 3.0 tons per capita, and the previous dominating source
      of emissions land use change has CO2 emissions of 0.34. In the end, the
      U.S. is no different to other countries when it comes to CO2 emissions as
      it followed the same trend."),
    
    h3("How has Cambodia CO2 emissions changed over the years?"),
    p("Cambodia started with the same standards as other countries: with solely
      land use changing CO2 emissions having emissions almost equal to 20 tons
      in 1950. In the 1960s, land use change emissions dropped, while no other
      CO2 emission sources rose. It continued to waver solely on land use CO2
      emissions until around the 2000s where oil crept into the picture and
      slowly (very slowly) grew. In more recent years like 2015, coal and cement
      CO2 emissions have been introduced and have grown slightly since. Today,
      the country’s total emissions is under 3 tons per capita with land use
      change emissions representing more than half (1.8 tons), oil representing
      0.5 tons, and coal and cement representing 0.3 tons each. As Cambodia
      continues to develop, I think that so will their CO2 emissions while their
      emission types balance between coal, gas, and oil -- slowly eliminating
      the land use change from their emissions."),
    
    h3("Why is this important?"),
    p("Analyzing this can help understand which state of development a
      developing country is in and with that, it can help with optimization or
      improvement based on the past successes and failures of other countries
      that have already experienced that development. With almost a vision into
      the future, these countries can structure themselves to be better than
      the already developed countries and establish themselves in a manner that
      deviates from the inefficient or harmful parts that established countries
      have.")
  )
)

year_input <- sliderInput(
  inputId = "year",
  label = "Select a Year of Interest",
  min = 1750, max = 2021,
  value = 2021,
  sep = ""
)

country_input <- checkboxGroupInput(
  inputId = "country",
  label = "Select a Country or Countries of Interest",
  choices = countries,
  selected = "United States",
  inline = TRUE
)

co2source_input <- checkboxGroupInput(
  inputId = "co2source",
  label = "Select CO2 Sources of Interest",
  choices = c("cement_co2_per_capita", "coal_co2_per_capita",
              "flaring_co2_per_capita", "gas_co2_per_capita",
              "land_use_change_co2_per_capita", "oil_co2_per_capita",
              "other_co2_per_capita"),
  selected = c("cement_co2_per_capita", "coal_co2_per_capita",
               "flaring_co2_per_capita", "gas_co2_per_capita",
               "land_use_change_co2_per_capita", "oil_co2_per_capita",
               "other_co2_per_capita")
)

interactive_tab <- tabPanel(
  "Interactive Chart",
  titlePanel("CO2 Emissions Chart"),
  sidebarLayout(
    sidebarPanel(
      year_input,
      co2source_input,
      country_input
    ),
    mainPanel(
      plotlyOutput("interactive"),
      h3("Why this chart?"),
      p("I used a bar chart for the purpose of showing the differences of
        emissions across different countries all while seeing the make-up of
        each countries emissions by themselves. With the stacked bar plot,
        not only is the difference between how CO2 emissions are divided by
        country are shown, but so is the difference between total CO2 emissions
        for each country selected can be seen. I think that this is important to
        see because it can show how a developed country and a developing country
        compare and also how they develop over time -- something that is
        possible because of the year slider to adjust the year.")
    )
  )
  
  
)

# Define UI for application that draws a histogram
ui <- shinyUI(navbarPage(
  "A5",
  intro_tab,
  interactive_tab
))
