# author: Group 1
# date: 2024-03-11

"This script reads specified data and creates a linear model, saving it to a RDS file and fitted model results as a CSV.
Usage: src/04_linear_model.R --train_path=<train_path> --outlierless_train=<outlierless_train> --output_path=<output_path> 
Options:
--train_path=<train_path>                 Path to the preprocessed training data file
--outlierless_train=<outlierless_train>   Path to the preprocessed outlierless training data file
--output_path=<output_path>               Path to the output files 
" -> doc

suppressMessages(library(tidyverse))
suppressMessages(library(tidymodels))
suppressWarnings(library(docopt))
source("R/fit_linear_model.R")

opt <- docopt(doc)

main <- function(train_path, outlierless_train, output_path) {

  # Reading the training data
  train_data <- read_csv(train_path)

  # Create linear model and recipe
  # Fit linear model
  lm_fit <- fit_linear_model(fatalities ~ width + length, train_data)

  # Save to RDS
  saveRDS(lm_fit, file.path(output_path, "01_linear_model.rds"))

  # Reading the outlierless training data
  train_data_o <- read_csv(outlierless_train)

  # Create linear model and recipe
  # Fit linear model
  outlierless_lm_fit <- fit_linear_model(fatalities ~ width + length, train_data_o)

  # Save to RDS
  saveRDS(outlierless_lm_fit, file.path(output_path, "02_linear_model_outlierless.rds"))
  
}

main(opt$train_path, opt$outlierless_train, opt$output_path)
