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
  }, deleteFile = FALSE)
  
  output$plot_studyperformance <- renderPlotly({
      if(input$select_relation == "Math v.s. Daily Consumption"){
        performance_plot <- d3 %>% 
          mutate(ave_grade = (G1.x + G2.x + G3.x)/3) %>%
          filter(school %in% input$select_school) %>% 
          group_by(Dalc.x, school) %>% 
          reframe(average_grades = mean(ave_grade))
        p <- ggplot(performance_plot,
                 aes(Dalc.x, average_grades, col = school)) +
          geom_line() +
          labs(x = "Daily Alcohol Consumption Levels", 
               y = "Math Course Average Grades") +
          xlim(input$level_range[1], input$level_range[2])
      }else{
        if(input$select_relation == "Math v.s. Weekend Consumption"){
          performance_plot <- d3 %>% 
            mutate(ave_grade = (G1.x + G2.x + G3.x)/3) %>% 
            filter(school %in% input$select_school) %>%
            group_by(Walc.x, school) %>% 
            reframe(average_grades = mean(ave_grade))
        p <- ggplot(performance_plot,
                      aes(Walc.x, average_grades, col = school)) +
            geom_line() +
            labs(x = "Weekend Alcohol Consumption Levels", 
                 y = "Math Course Average Grades") +
            xlim(input$level_range[1], input$level_range[2])
        }else{
          if(input$select_relation == "Portuguese v.s. Daily Consumption"){
            performance_plot <- d3 %>% 
              mutate(ave_grade = (G1.y + G2.y + G3.y)/3) %>%
              filter(school %in% input$select_school) %>%
              group_by(Dalc.y, school) %>% 
              reframe(average_grades = mean(ave_grade)) 
        p <- ggplot(performance_plot,
                          aes(Dalc.y, average_grades, col = school)) +
              geom_line() +
              labs(x = "Daily Alcohol Consumption Levels", 
                   y = "Portuguese Course Average Grades") +
              xlim(input$level_range[1], input$level_range[2])
          }else{
            if(input$select_relation == "Portuguese v.s. Weekend Consumption"){
              performance_plot <- d3 %>% 
                mutate(ave_grade = (G1.y + G2.y + G3.y)/3) %>% 
                filter(school %in% input$select_school) %>%
                group_by(Walc.y, school) %>% 
                reframe(average_grades = mean(ave_grade))
        p <- ggplot(performance_plot,
                           aes(Walc.y, average_grades, col = school)) +
                geom_line() +
                labs(x = "Weekend Alcohol Consumption Levels", 
                     y = "Portuguese Course Average Grades") +
                xlim(input$level_range[1], input$level_range[2])
            }
        }
      }
    }
    ggplotly(p, height = 500, width = 700)
  })
  
}

shinyServer(server)
