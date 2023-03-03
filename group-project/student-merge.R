library(tidyverse)
library(ggplot2)

setwd("~/Documents/info201wi23/GroupProject/group-project/")
d1 <- read_delim("student-mat.csv")
d2 <- read_delim("student-por.csv")

d3 <- merge(d1, d2, by = c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet"))
print(nrow(d3)) # 382 students

row.names(d3) <- as.character(1:382)

## d3 %>%
  ## select(age, school, G1.x, G2.x, G3.x, Dalc.x) %>% 
  ## mutate(ave_grade = (G1.x+G2.x+G3.x)/3,
        ## student_id = rownames(d3)) %>% 
  ## filter(Dalc.x == 5) %>% 
  ## ggplot(aes(student_id, ave_grade, col = factor(Dalc.x))) +
  ## geom_point()

## d3 %>% 
  ## select(age, school, G1.x, G2.x, G3.x, Dalc.x) %>% 
  ## mutate(aver = (G1.x + G2.x + G3.x)/3) %>% 
  ## group_by(Dalc.x) %>% 
  ## reframe(ave_grade = mean(aver)) %>% 
  ## ggplot(aes(Dalc.x, ave_grade)) +
  ## geom_line()
  
