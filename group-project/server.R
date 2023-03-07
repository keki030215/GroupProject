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
  })
  output$plot_studyperformance <- renderPlotly({
    study_performance <- d3 %>% 
      GP <- "Gabriel Pereira" %>%
      MP <- "Mousinho da Silveira"
      filter(school == input$select_school) %>% 
      if(input$select_relation == "Math v.s. Daily Consumption"){
        muatate(ave_grade = (G1.x + G2.x + G3.x)/3)
      }
    p <- ggplot(uah_plot, aes(time, temp, col = region)) +
      geom_point(size = 0.5) +
      labs(x = "Year", y = "Temperature", col = "Region") +
      xlim(input$year_range[1], input$year_range[2]) +
      if (input$color_palette == "Palette 2"){
        scale_color_brewer(palette = "Dark2")
      }
    ggplotly(p, height = 500, width = 700)
  })
}

shinyServer(server)
