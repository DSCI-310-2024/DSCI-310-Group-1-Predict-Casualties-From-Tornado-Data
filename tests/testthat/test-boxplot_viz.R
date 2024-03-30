library(ggplot2)
library(vdiffr)
source("../../R/boxplot_viz.R")

test_that("refactoring our code should not change our plot", {
  expect_doppelganger("boxplot viz", test_boxplot)
})

test_that("The data frame should not be empty", {
  expect_error(boxplot_viz(empty_df, fatalities))
})

test_that("'col' should be a column name in the data frame", {
  expect_error(boxplot_viz(test_boxplot_data, missing_col))
})

test_that("`data` should be a data frame", {
  expect_error(boxplot_viz(list_input, fatalities))
  expect_error(boxplot_viz("string", fatalities))
})

