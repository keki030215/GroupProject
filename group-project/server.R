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
         width = 250,
         height = 250)
  }, deleteFile = FALSE)
  
# Tab 1 - Liuhan 
  output$plot_studyperformance <- renderPlotly({
    if(is.null(input$select_school)){
      p <- ggplot(d3) +
        labs(title = "Please select a school :)",
             x = "Alcohol Consumption Levels",
             y = "Course Average Grades") +
        xlim(1, 5) + ylim(0, 15)
    }else{
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
               y = "Math Course Average Grades")
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
                 y = "Math Course Average Grades")
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
                   y = "Portuguese Course Average Grades")
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
                     y = "Portuguese Course Average Grades")
            }
        }
      }
     }
    }
    ggplotly(p)
  })
  
  # Jaiden's server Code:
  # Plot
  output$plot <- renderPlot({
    ggplot(d3[, c("Pstatus", "school", "sex", 
                            "Dalc.x", "Dalc.y", "Walc.x",
                            "Walc.y", "G1.x", "G1.y", 
                            "G2.x", "G2.y", "G3.x", "G3.y")], 
           aes_string(x = input$x_axis, y = input$y_axis, color = 
                        ifelse(input$color_var == "None", "NULL", 
                               input$color_var))) +
      geom_jitter() +
      ggtitle(paste(input$y_axis, "in comparison to", input$x_axis)) +
      xlab(input$x_axis) +
      ylab(input$y_axis)
  })
  
# Tab 3 - Liuhan
    output$hist_plot <- renderPlotly({
      p_hist <- d3 %>% 
        ggplot(aes_string(input$select_variable, 
                          fill = input$select_group)) +
        geom_histogram(stat = "count", position = "dodge2")
      ggplotly(p_hist)
    })
    output$hist_text <- renderText({
      paste("The histogram now displays the variable",
            input$select_variable, ", and now it is grouped by",
            input$select_group, ".")
    })
    
    output$sampleMain <- renderDataTable({
      d3[sample(nrow(d3), 10), ]
    })
}

shinyServer(server)
