library(ggplot2)
library(vdiffr)
source("../../R/create_scatterplot.R")

test_that("refactoring our code should not change our plot", {
  expect_doppelganger("create scatterplot", body_plot)
})

test_that("The data frame should call columns that exist within the data frame", {
  expect_error(create_scatterplot(wrong_cols_plot))
})

test_that("The data frame should not have empty columns", {
  expect_error(create_scatterplot(empty_plot))
})

test_that("`data` should be a data frame", {
  expect_error(create_scatterplot(list_input))
})

test_that('The plot should use geom_point.', {
  expect_true("GeomPoint" %in% c(class(body_plot$layers[[1]]$geom)))
})

test_that('The plot should map `x_col` to x-axis and `y_col` to y-axis.', {
  expect_true("height" == rlang::get_expr(body_plot$mapping$x))
  expect_true("weight" == rlang::get_expr(body_plot$mapping$y))
})
