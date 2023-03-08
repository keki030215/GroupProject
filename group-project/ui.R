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
               fluidRow(
                 column(width = 4,
               imageOutput("overview_image")),
               column(width = 8,
               h2("Project Purpose"),
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
                 The dataset consists of two separate files - one for math courses and another for Portuguese language courses."))
               )
               ),
# Tab 1 - Liuhan
      tabPanel("v.s. Academic Performances",
               fluidRow(
                 column(width = 4, 
                        h3("Variable Information"),
                        p("In the following three widgets,
                          we can select", strong("school(s)"), 
                          "and the", strong("relationship"),"we want
                          to focus on."),
                        p('The school “GP” and “MS” here stand for 
                          two different schools: ', strong("GP"),
                        "- School Gabriel Pereira", ", and", 
                        strong("MS"), "- School Mousinho da Silveira."),
                        h3("Selection"),
                 sidebarPanel(width = 12,
                   checkboxGroupInput("select_school", "Select School(s):",
                     choices = c("GP", "MS"),
                     selected = "GP"),
                   radioButtons("select_relation", 
                                      "Select the relation:",
                                      c("Math v.s. Daily Consumption",
                                        "Math v.s. Weekend Consumption",
                                        "Portuguese v.s. Daily Consumption",
                                        "Portuguese v.s. Weekend Consumption"),
                                      selected = "Math v.s. Daily Consumption"
                                      )
                  )
                 ),
                 column(width = 8,
                        h3("Basic Information"),
                        p("The plot demonstrates the relationship between", 
                          em("alcohol consumption levels"), strong("(workdays 
                          and weekends  respectively)"), "and", em("academic 
                          performance"), "in the", strong("math"), "course 
                          or the", strong("Portuguese"), "course."),
                        p("The average grades are calculated from the mean
                        of students' three tests in the corresponding course."),
                   h3("Line Plot"),
                   plotlyOutput("plot_studyperformance"),
                 )
               )
      ),
      
# Jaiden's code
tabPanel("v.s. Parents’ Cohabitation Status",
         fluidRow(
           column(width = 4,
                  h3("Plot Information"),
                  p("The Plot page uses scatterplot format and allows you
to visualize the relationship between two variables of
your choice, allowing for detailed analysis. Specific variables are focused on here
to answer the second question on our Overview page. You can also choose
to color the points based on sex, school, or
PStatus (Parents Cohabition) if desired."),
                  h3("Variable Selection"),
                  sidebarPanel(width = 12,
                    selectInput("x_axis", "X-axis:", c("Pstatus",
                                                       "Dalc.x", "Dalc.y", "Walc.x",
                                                       "Walc.y")),
                    selectInput("y_axis", "Y-axis:", c("Pstatus",
                                                       "Dalc.x", "Dalc.y", "Walc.x",
                                                       "Walc.y")),
                    selectInput("color_var", "Color by:", c("None",
                                                            c("school",
                                                              "sex",
                                                              "Pstatus",
                                                              "Dalc.x", "Dalc.y", "Walc.x",
                                                              "Walc.y")))
                  )
           ),
           column(width = 8,
                  h3("Plot"),
                  plotOutput("plot"),
                  h3("Variable Labels:"),
                  fluidRow(
                    column(width = 6,
                           p(strong("school")," - student's school ('GP' - Gabriel Pereira or 'MS' - Mousinho da Silveira)"),
                           p(strong("sex"), " - student's sex (F - female or M - male)"),
                           p(strong("Pstatus"), " - parent's cohabitation status (T - living together or A - apart)"),
                           p(strong("Dalc.x"), " - workday alcohol consumption for MATH students (numeric: from 1 - very low to 5 - very high)"),
                           p(strong("Dalc.y"), " - workday alcohol consumption for PORTUGUESE students (numeric: from 1 - very low to 5 - very high)"),
                           p(strong("Walc.x"), " - weekend alcohol consumption for MATH students (numeric: from 1 - very low to 5 - very high)"),
                           p(strong("Walc.y"), " - weekend alcohol consumption for PORTUGUESE students (numeric: from 1 - very low to 5 - very high)")),
                    column(width = 6,
                           p(strong("G1.x"), " - first period grade, for MATH students (numeric: from 0 to 20)"),
                           p(strong("G1.y"), " - first period grade, for PORTUGUESE s†udents (numeric: from 0 to 20)"),
                           p(strong("G2.x"), " - second period grade, for MATH students (numeric: from 0 to 20)"),
                           p(strong("G2.y"), "- second period grade, for PORTUGUESE s†udents (numeric: from 0 to 20)"),
                           p(strong("G3.x"), " - final grade of the school year, for MATH students (numeric: from 0 to 20)"),
                           p(strong("G3.y"), " - final grade of the school year, for PORTUGUESE s†udents (numeric: from 0 to 20)")
                           )
                  )
           )
         ),
),
      tabPanel("Histogram View",
               fluidRow(
                 column(width = 4,
                        h3("Basic Information"),
                        p("The histogram demonstrates the frequency of", 
                          strong("variables (have more than 2 levels)"), 
                          "that are not shown in the two previous page before, 
                          and the selected variable is grouped by", 
                          strong("binary variables"),  "provided by the data set."),
                        h3("Variable Selection"),
                        sidebarPanel(width = 12,
                  selectInput("select_variable", "Select the variable:",
                              choices = c("Mjob", "Fjob",
                                          "Medu", "Fedu",
                                          "reason", "guardian",
                                          "health.x", "health.y", 
                                          "traveltime.x", "traveltime.y",
                                          "studytime.x", "studytime.y",
                                          "failures.x", "failures.y",
                                          "famrel.x", "famrel.y",
                                          "freetime.x", "freetime.y",
                                          "goout.x", "goout.y",
                                          "absences.x", "absences.y"),
                           ),
                  selectInput("select_group", 
                              "Select the variable 
                              that will group up the data:",
                               choices = c("sex", "address", "famsize",
                                           "nursery", "internet",
                                           "schoolsup.x", "schoolsup.y",
                                           "famsup.x", "famsup.y",
                                           "paid.x", "paid.y",
                                           "activities.x", "activities.y",
                                           "higher.x", "higher.y",
                                           "romantic.x", "romantic.y")),
                  h4(em("Explanation:")), 
                  p("Variable with suffix", strong('"-x"'), "is data from the", 
                     strong("Math"), "class."),
                  p("Variable with suffix", strong('"-y"'), "is data from the", 
                     strong("Portuguese"), "class.")
                 )
                 ),
                 column(width = 8,
                        h3("Histogram"),
                        textOutput("hist_text"),
                        plotlyOutput("hist_plot"),
                        h3("Variable Labels:"),
                        fluidRow(
                          column(width = 6,
                                 h4("Multiple Level (>2) Variables:"),
                                 p(strong("Mjob"), "- mother's job (nominal: 'teacher', 'health' care related, civil 'services' (e.g. administrative or police), 'at_home' or 'other')"), 
                                 p(strong("Fjob"), "- father's job (nominal: 'teacher', 'health' care related, civil 'services' (e.g. administrative or police), 'at_home' or 'other')"),
                                 p(strong("Medu"), " - mother's education (numeric: 0 - none, 1 - primary education (4th grade), 2 – 5th to 9th grade, 
                                   3 – secondary education or 4 – higher education)"),
                                 p(strong("Fedu"), "- father's education (numeric: 0 - none, 1 - primary education (4th grade), 2 – 5th to 9th grade, 
                                 3 – secondary education or 4 – higher education"),
                                 p(strong("reason"), " - reason to choose this school (nominal: close to 'home', school 'reputation', 'course' preference or 'other')"),
                                 p(strong("guardian"), "- student's guardian (nominal: 'mother', 'father' or 'other')"),
                                 p(strong("traveltime"), " - home to school travel time (numeric: 1 - <15 min., 2 - 15 to 30 min., 3 - 30 min. to 1 hour, or 4 - >1 hour)"),
                                 p(strong("studytime"), "- weekly study time (numeric: 1 - <2 hours, 2 - 2 to 5 hours, 3 - 5 to 10 hours, or 4 - >10 hours)"),
                                 p(strong("failures"), " - number of past class failures (numeric: n if 1<=n<3, else 4)"),
                                 p(strong("famrel"), "- quality of family relationships (numeric: from 1 - very bad to 5 - excellent)")
                                 ),
                          column(width = 6,
                                 p(strong("freetime"), " - free time after school (numeric: from 1 - very low to 5 - very high)"),
                                 p(strong("goout"), "- going out with friends (numeric: from 1 - very low to 5 - very high)"),
                                 p(strong("health"), "- current health status (numeric: from 1 - very bad to 5 - very good)"),
                                 p(strong("absences"), "- number of school absences (numeric: from 0 to 93)"), 
                                 h4("Binary Variables:"),
                                 p(strong("sex"), " - student's sex (F - female or M - male)"),
                                 p(strong("address"), "- student's home address type (binary: 'U' - urban or 'R' - rural)"),
                                 p(strong("famsize"), " - family size (binary: 'LE3' - less or equal to 3 or 'GT3' - greater than 3)"),
                                 p(strong("schoolsup"), "- extra educational support (binary: yes or no)"),
                                 p(strong("famsup"), "- family educational support (binary: yes or no)"),
                                 p(strong("paid"), "- extra paid classes within the course subject (Math or Portuguese) (binary: yes or no)"),
                                 p(strong("activities"), "- extra-curricular activities (binary: yes or no)"),
                                 p(strong("nursery"), "- attended nursery school (binary: yes or no)"),
                                 p(strong("higher"), "- wants to take higher education (binary: yes or no)"),
                                 p(strong("internet"), "- Internet access at home (binary: yes or no)"),
                                 p(strong("romantic"), "- with a romantic relationship (binary: yes or no)")
                          ),
                        ))
               )
      ),
      tabPanel("Conclusion"),
    )
  ),
)

shinyUI(ui)