# helper functions for boxplot_viz function

library(ggplot2)
source("../../R/boxplot_viz.R")

test_boxplot_data <- data.frame("fatalities" = c(0, 0, 1, 1, 2, 2, 5, 10, 15), 
                                "magnitude" = c(1, 2, 3, 4, 5, 6, 7, 8, 9))

test_boxplot <- boxplot_viz(test_boxplot_data, fatalities) + labs(x = "Fatalities",  
               title = "Boxplot of Fatalities")

empty_df  <- data.frame()

list_input <- list('item', 'item2')