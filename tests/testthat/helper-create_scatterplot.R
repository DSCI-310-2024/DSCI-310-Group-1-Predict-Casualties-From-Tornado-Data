# function inputs for tests for create_scatterplot

library(ggplot2)
source("../../R/create_scatterplot.R")

body_data <- data.frame("height" = c(1.61, 1.50, 1.78, 1.86, 1.52),
                        "weight" = c(45, 40, 67, 81, 51))

body_plot <- create_scatterplot(body_data, height, weight) + labs(x = "Height (m)", y = "Weight (kg)", 
               title = "Scatterplot of height and weight of people")

empty_df  <- data.frame()

list_input <- list('hello', 'five')
