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
      tabPanel("Overview",
               imageOutput("overview_image"),
               titlePanel("Project Purpose"),
               p("The data were obtained in a survey of students' 
                  math and Portuguese language courses in secondary school. 
                  It contains a lot of interesting social, gender and study 
                  information about students. 
                  You can use it for some EDA or try to predict students' final grade."), 
               p("In this report provide an overview of how alcoholic assumptions influence students’ 
                  grades and health conditions. "),
               h2("Focused Objectives From Data"),
               p("1. How alcohol consumption would affect academic performances."),
               p("2. If there is a relationship between alcohol consumption and parents’ cohabitation status."),
               p("3. Whether the workdays alcohol consumption and weekends alcohol consumption would have different effects."),
               h2("Audience"),
               p("Individuals who are interested in conducting research on the potential correlation 
                  between a student's academic performance and overall health with alcohol consumption 
                  may find this dataset useful. Additionally, this information may be of interest to 
                  students, parents, or other parties who wish to understand how alcohol consumption can 
                  impact a student's grades and health."),
               h2("Data Set"),
               a("We accessed the data through Kaggle.com.",href='https://www.kaggle.com/datasets/uciml/student-alcohol-consumption'),
               p("The dataset contains information about the alcohol consumption habits of Portuguese secondary school students. 
                 The data was collected through a survey and includes a variety of attributes such as demographic information, 
                 family background, study-related variables, and alcohol consumption patterns. 
                 The dataset consists of two separate files - one for math courses and another for Portuguese language courses."),
               ),
      tabPanel("Study Performances",
               sidebarLayout(
                 sidebarPanel(
                   checkboxGroupInput("select_school", "Select School(s):",
                     choices = c("GP", "MS"),
                     selected = "GP"),
                   sliderInput(
                     "level_range", 
                     "Select the range of the alcohol consumption levels 
                     (from low to high):",
                     min = 1, max = 5, 
                     value = c(1, 5)),
                   radioButtons("select_relation", 
                                      "Select the relation(s):",
                                      c("Math v.s. Daily Consumption",
                                        "Math v.s. Weekend Consumption",
                                        "Portuguese v.s. Daily Consumption",
                                        "Portuguese v.s. Weekend Consumption"),
                                      selected = "Math v.s. Daily Consumption"
                                      )
                 ),
                 mainPanel(
                   plotlyOutput("plot_studyperformance",
                                height = 500, width = 800)
                 )
               )
      ),
      
# Jaiden's code
tabPanel("Alcohol Consumption and Parents’ Cohabitation Status",
         fluidRow(
           column(width = 4,
                  h3("Plot Information"),
                  p("The Plot page uses scatterplot format and allows you
to visualize the relationship between two variables of
your choice, allowing for detailed analysis. Specific variables are focused on here
to answer the second question on our Overview page. You can also choose
to color the points based on sex, school, or
PStatus (Parents Cohabition) if desired."),
                  h3("Variable Labels:"),
                  p("school - student's school ('GP' - Gabriel Pereira or 'MS' - Mousinho da Silveira)"),
                  p("sex - student's sex (F - female or M - male)"),
                  p("Pstatus - parent's cohabitation status (T - living together or A - apart)"),
                  p("Dalc.x - workday alcohol consumption for MATH students (numeric: from 1 - very low to 5 - very high)"),
                  p("Dalc.y - workday alcohol consumption for PORTUGUESE students (numeric: from 1 - very low to 5 - very high)"),
                  p("Walc.x - weekend alcohol consumption for MATH students (numeric: from 1 - very low to 5 - very high)"),
                  p("Walc.y - weekend alcohol consumption for PORTUGUESE students (numeric: from 1 - very low to 5 - very high)"),
                  p("G1.x - first period grade, for MATH students (numeric: from 0 to 20)"),
                  p("G1.y - first period grade, for PORTUGUESE s†udents (numeric: from 0 to 20)"),
                  p("G2.x - second period grade, for MATH students (numeric: from 0 to 20)"),
                  p("G2.y - second period grade, for PORTUGUESE s†udents (numeric: from 0 to 20)"),
                  p("G3.x - final grade of the school year, for MATH students (numeric: from 0 to 20)"),
                  p("G3.y - final grade of the school year, for PORTUGUESE s†udents (numeric: from 0 to 20)"),
                  
           ),
           column(width = 8,
                  h3("Plot"),
                  plotOutput("plot", height = 500, width = 800)
           )
         ),
         sidebarLayout(
           sidebarPanel(
             selectInput("x_axis", "X-axis:", c("Pstatus",
                                                "Dalc.x", "Dalc.y", "Walc.x",
                                                "Walc.y", "G1.x", "G1.y",
                                                "G2.x", "G2.y", "G3.x", "G3.y")),
             selectInput("y_axis", "Y-axis:", c("Pstatus",
                                                "Dalc.x", "Dalc.y", "Walc.x",
                                                "Walc.y", "G1.x", "G1.y",
                                                "G2.x", "G2.y", "G3.x", "G3.y")),
             selectInput("color_var", "Color by:", c("None",
                                                     c("school",
                                                       "sex",
                                                       "Pstatus",
                                                       "Dalc.x", "Dalc.y", "Walc.x",
                                                       "Walc.y", "G1.x", "G1.y",
                                                       "G2.x", "G2.y", "G3.x", "G3.y")))
           ),
           mainPanel()
         )
),
      tabPanel("histogram view",
               selectInput("select_variable")
      ),
      tabPanel("Conclusion")
    )
  ),
)

shinyUI(ui)