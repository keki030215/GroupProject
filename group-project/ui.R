library(shiny)
library(tidyverse)
library(ggplot2)
library(plotly)

ui <- fluidPage(
  titlePanel("Student Alcohol Consumption"),
  mainPanel(
    tabsetPanel(
      tabPanel(""),
      tabPanel(""),
      tabPanel(""),
      tabPanel(""),
      tabPanel("")
    )
  )
)

shinyUI(ui)