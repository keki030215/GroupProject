library(shiny)
library(tidyverse)
library(ggplot2)
library(plotly)

ui <- fluidPage(
  titlePanel("Student Alcohol Consumption"),
  mainPanel(
    tabsetPanel(
      tabPanel("Overview"),
      tabPanel("Study Performances",
               sidebarLayout(
                 sidebarPanel(
                   
                 ),
                 mainPanel(
                   
                 )
               )
      ),
      tabPanel("2"),
      tabPanel("3"),
      tabPanel("Conclusion")
    )
  )
)

shinyUI(ui)