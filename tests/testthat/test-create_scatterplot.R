library(ggplot2)
library(vdiffr)
source("../../R/create_scatterplot.R")

fatalities_width_scatterplot <- create_scatterplot(tornado_train_data, 
  width, fatalities) + 
  labs(x = "Width of tornadoes (yards)", y = "Fatalities", 
  title = "Figure 2: Scatterplot of width (yards) of tornado and fatalities")
fatalities_width_scatterplot 

fatalities_length_scatterplot <- create_scatterplot(tornado_train_data, 
  length, fatalities) + 
  labs(x = "Length of tornadoes (miles)", y = "Fatalities", 
       title = "Figure 3: Scatterplot of length (miles) of tornado and fatalities")
fatalities_length_scatterplot 

test_that("refactoring our code should not change our plot", {
  expect_doppelganger("create scatterplot1", fatalities_width_scatterplot)
})

test_that("refactoring our code should not change our plot", {
  expect_doppelganger("create scatterplot2", fatalities_length_scatterplot)
})