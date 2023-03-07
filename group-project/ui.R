library(shiny)
library(tidyverse)
library(ggplot2)
library(plotly)

d1 <- read_delim("student-mat.csv")
d2 <- read_delim("student-por.csv")
d3 <- merge(d1, d2, by = c("school","sex","age","address",
                           "famsize","Pstatus","Medu","Fedu",
                           "Mjob","Fjob","reason","nursery","internet"))


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