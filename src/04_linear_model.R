# author: Group 1
# date: 2024-03-11

"This script reads specified data and creates a linear model, saving it to a RDS file and fitted model results as a CSV.
Usage: src/04_linear_model.R --train_path=<train_path> --model_path=<model_path> --results_path=<results_path> 
Options:
--train_path=<train_path>     Path to the preprocessed training data file
--model_path=<model_path>     Path to where the model will be saved (RDS)
--results_path=<results_path>     Path to where the model results will be saved (CSV)
" -> doc

suppressMessages(library(tidyverse))
suppressMessages(library(tidymodels))
suppressWarnings(library(docopt))

opt <- docopt(doc)

main <- function(train_path, model_path, results_path) {

  # Reading the training data
  train_data <- read_csv(train_path)
  
  # Create linear model and recipe
  lm_spec <- linear_reg() %>%
    set_engine("lm") %>%
    set_mode("regression")
  
  lm_recipe <- recipe(fatalities ~ width + length, data = data)
  
  # Fit linear model and save to RDS
  lm_fit <- workflow() %>%
    add_recipe(lm_recipe) %>%
    add_model(lm_spec) %>%
    fit(data = train_data)
  
  saveRDS(lm_fit, model_path)
  
  # Extract and save model results to CSV
  model_results <- tidy(lm_fit)
  
  write_csv(model_results, results_path)
}

main(opt$train_path, opt$model_path, opt$results_path)
