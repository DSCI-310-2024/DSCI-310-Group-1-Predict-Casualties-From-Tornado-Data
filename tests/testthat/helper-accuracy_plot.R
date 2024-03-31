# helper fucntions inputs for accuracy_plot

library(ggplot2)
library(tidyverse)
library(tidymodels)
source("../../R/accuracy_plot.R")
source("../../R/fit_linear_model.R")

lin_model_data <- data.frame('x' = c(1, 2, 1, 1, 2, 3, 6, 5, 7, 4), 
           'y' = c(1, 2, 3, 1, 2, 3, 1, 2, 3, 1),
           'z' = c(3, 6, 5, 3, 6, 9, 13, 12, 17, 9))

lm_data <- fit_linear_model(z ~ x + y, lin_model_data) |>
    predict(lin_model_data) |>
    bind_cols(lin_model_data)


test_accuracy_plot <- accuracy_plot(lm_data, x) + labs(x = "X", y = "Predicted X", 
               title = "Scatterplot of X and Predicted X")

empty_df <- data.frame()

list_data <- list('item', 'item2')

