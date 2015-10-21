library(shiny)
library(leaflet)
library(ggplot2)
library(ggthemes)
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  titlePanel("Developing Data Products Project"),
  
  sidebarLayout(
    sidebarPanel(
      uiOutput("stateList"),
      uiOutput("categoryList")
    ),
    mainPanel(
      leafletOutput("mymap",height = 300),
      plotOutput("bizStar")
    )
  )
))