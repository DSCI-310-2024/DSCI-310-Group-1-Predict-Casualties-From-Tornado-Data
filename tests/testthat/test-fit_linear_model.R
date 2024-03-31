library(testthat)
library(tidymodels)
library(dplyr)
source("../../R/fit_linear_model.R")

testthat_data <- tibble(
  x = 1:10,
  z = 2:11,
  y = 2 * (1:10) + 1 * (2:11)
)

error_data <- "data"
error_formula <- "formula"

test_that("'fit_linear_model' should return a workflow object when using one variable", {
  result <- fit_linear_model(y ~ x, testthat_data)
  expect_equal(class(result), "workflow")
})

test_that("'fit_linear_model' should return a workflow object when using two variables", {
  result <- fit_linear_model(y ~ x + z, testthat_data)
  expect_equal(class(result), "workflow")
})

test_that("'fit_linear_model' should throw an error for incorrect data types", {
  expect_error(fit_linear_model(y ~ x, error_data))
})

test_that("'fit_linear_model' should throw an error for incorrect formula types", {
  expect_error(fit_linear_model(incorrect_error, testthat_data))
})

