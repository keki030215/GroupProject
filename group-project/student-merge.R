library(tidyverse)
library(ggplot2)

d1 <- read_delim("student-mat.csv")
d2 <- read_delim("student-por.csv")
d3 <- merge(d1, d2, by = c("school","sex","age","address",
                           "famsize","Pstatus","Medu","Fedu",
                           "Mjob","Fjob","reason","nursery","internet"))
print(nrow(d3)) # 382 students

row.names(d3) <- as.character(1:382)
  