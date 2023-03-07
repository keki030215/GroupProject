library(shiny)
library(tidyverse)
library(ggplot2)
library(plotly)

d1 <- read_delim("student-mat.csv")
d2 <- read_delim("student-por.csv")
d3 <- merge(d1, d2, by = c("school","sex","age","address",
                           "famsize","Pstatus","Medu","Fedu",
                           "Mjob","Fjob","reason","nursery","internet"))

server <- function(input, output) {
  output$overview_image <- renderImage({
    list(src = "alcohol.jpg",
         width = 400,
         height = 300)
  }, deleteFile=FALSE)
  
  output$plot_studyperformance <- renderPlotly({
    var <- input$select_relation
      if(var == "Math v.s. Daily Consumption"){
        performance_plot <- d3 %>% 
          filter(school == input$select_school) %>% 
          mutate(ave_grade = (G1.x + G2.x + G3.x)/3) %>% 
          group_by(Dalc.x) %>% 
          reframe(average_grades = mean(ave_grade))
        p <- ggplot(performance_plot, aes(Dalc.x, average_grades)) +
          geom_line() +
          labs(x = "Daily Alcohol Consumption", 
               y = "Math Course Average Grades")
      }else{
        if(var == "Math v.s. Weekend Consumption"){
          performance_plot <- d3 %>% 
            filter(school == input$select_school) %>%
            mutate(ave_grade = (G1.x + G2.x + G3.x)/3) %>% 
            group_by(Walc.x) %>% 
            reframe(average_grades = mean(ave_grade))
          p <- ggplot(performance_plot, aes(Walc.x, average_grades)) +
            geom_line() +
            labs(x = "Weekend Alcohol Consumption", 
                 y = "Math Course Average Grades")
        }else{
          if(var == "Portuguese v.s. Daily Consumption"){
            performance_plot <- d3 %>% 
              filter(school == input$select_school) %>%
              mutate(ave_grade = (G1.y + G2.y + G3.y)/3) %>% 
              group_by(Dalc.y) %>% 
              reframe(average_grades = mean(ave_grade))
            p <- ggplot(performance_plot, aes(Dalc.y, average_grades)) +
              geom_line() +
              labs(x = "Daily Alcohol Consumption", 
                   y = "Portuguese Course Average Grades")
          }else{
            if(var == "Portuguese v.s. Weekend Consumption"){
              performance_plot <- d3 %>% 
                filter(school == input$select_school) %>%
                mutate(ave_grade = (G1.y + G2.y + G3.y)/3) %>% 
                group_by(Walc.y) %>% 
                reframe(average_grades = mean(ave_grade))
              p <- ggplot(performance_plot, aes(Walc.y, average_grades)) +
                geom_line() +
                labs(x = "Weekend Alcohol Consumption", 
                     y = "Portuguese Course Average Grades")
          }
        }
      }
    }
    ggplotly(p, height = 500, width = 700)
  })
  
}

shinyServer(server)
