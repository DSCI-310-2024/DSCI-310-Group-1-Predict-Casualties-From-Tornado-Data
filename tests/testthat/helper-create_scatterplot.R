# function inputs for tests for create_scatterplot

library(ggplot2)
source("../../R/create_scatterplot.R")

body_data <- data.frame("height" = c(1.61, 1.50, 1.78, 1.86, 1.52),
                        "weight" = c(45, 40, 67, 81, 51))

body_plot <- create_scatterplot(body_data, height, weight) + labs(x = "Height (m)", y = "Weight (kg)", 
               title = "Scatterplot of height and weight of people")

wrong_cols_plot <- create_scatterplot(body_data, height, BMI) + labs(x = "Height (m)", y = "BMI", 
                   title = "Scatterplot of height and BMI of people")

empty_cols_df <- data.frame("age", "height")

empty_plot <- create_scatterplot(empty_cols_df, age, height)

list_input <- list('hello', 'five')
