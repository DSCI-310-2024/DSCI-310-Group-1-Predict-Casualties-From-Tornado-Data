library(ggplot2)
library(vdiffr)
source("../../R/boxplot_viz.R")

test_that("refactoring our code should not change our plot", {
  expect_doppelganger("boxplot viz", test_boxplot)
})

test_that("The data frame should not be empty", {
  expect_error(boxplot_viz(empty_df, test_boxplot_data))
})

test_that("`data` should be a data frame", {
  expect_error(boxplot_viz(list_input, test_boxplot_data))
})