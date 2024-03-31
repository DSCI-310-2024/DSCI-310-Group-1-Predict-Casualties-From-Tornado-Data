library(ggplot2)
library(vdiffr)
source("../../R/accuracy_plot.R")

test_that("refactoring our code should not change our plot", {
  expect_doppelganger("accuracy plot", test_accuracy_plot)
})

test_that("The data frame should not be empty", {
  expect_error(accuracy_plot(accuracy_plot(empty_df, x)))
})

test_that("`predictions` should be a data frame", {
  expect_error(accuracy_plot(list_data))
})