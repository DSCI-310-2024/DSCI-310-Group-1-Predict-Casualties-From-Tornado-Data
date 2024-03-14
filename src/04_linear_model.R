# author: Group 1
# date: 2024-03-11

"This script reads specified data and creates a linear model, saving it to a RDS file and fitted model results as a CSV.
Usage: src/04_linear_model.R --train_path=<train_path> --outlierless_train=<outlierless_train>  
Options:
--train_path=<train_path>                 Path to the preprocessed training data file
--outlierless_train=<outlierless_train>   Path to the preprocessed outlierless training data file
" -> doc

suppressMessages(library(tidyverse))
suppressMessages(library(tidymodels))
suppressWarnings(library(docopt))

opt <- docopt(doc)

main <- function(train_path, outlierless_train) {

  # Reading the training data
  train_data <- read_csv(train_path)
  
  # Create linear model and recipe
  lm_spec <- linear_reg() %>%
    set_engine("lm") %>%
    set_mode("regression")
  
  lm_recipe <- recipe(fatalities ~ width + length, data = train_data)
  
  # Fit linear model and save to RDS
  lm_fit <- workflow() %>%
    add_recipe(lm_recipe) %>%
    add_model(lm_spec) %>%
    fit(data = train_data)
  
  saveRDS(lm_fit, "results/01_linear_model.rds")

  # Reading the outlierless training data
  train_data_o <- read_csv(outlierless_train)
  
  # Create linear model and recipe
  lm_recipe_o <- recipe(fatalities ~ width + length, data = train_data_o)
  
  # Fit linear model and save to RDS
  outlierless_lm_fit <- workflow() %>%
    add_recipe(lm_recipe) %>%
    add_model(lm_spec) %>%
    fit(data = train_data_o)

  saveRDS(outlierless_lm_fit, "results/02_linear_model_outlierless.rds")
  
}

main(opt$train_path, opt$outlierless_train)
