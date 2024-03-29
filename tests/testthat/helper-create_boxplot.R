# helper functions for boxplot_viz function

library(ggplot2)
source("../../R/boxplot_viz.R")

test_boxplot_data <- data.frame("fatalities" = c(0, 0, 1, 1, 2, 2, 5, 10, 15))

test_boxplot <- boxplot_viz(test_boxplot_data, fatalities) + labs(x = "Fatalities",  
               title = "Boxplot of Fatalities")

empty_df  <- data.frame()

list_input <- list('item', 'item2')