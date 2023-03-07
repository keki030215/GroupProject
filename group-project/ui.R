library(shiny)
library(tidyverse)
library(ggplot2)
library(plotly)

ui <- fluidPage(
  titlePanel("Student Alcohol Consumption"),
  mainPanel(
    tabsetPanel(
      tabPanel("Overview"),
      tabPanel("Study Performances"),
      tabPanel(""),
      tabPanel(""),
      tabPanel("Conclusion")
    )
  )
)

shinyUI(ui)