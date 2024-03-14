"This script creates takes the test data and linear regression model and uses
them to create scatterplots used to assess the accuracy of the regression model.
Additionally, this script creates boxplots from the test data to assess the 
outliers in the data set.

Usage: 05_linear_model_results.R --test_data=<test_data> --outlierless_train<outlierless_train> --outlierless_test<outlierless_test>  --lin_fit=<lin_fit> 

Options:
--test_data=<test_data>                 Path to the test data
--outlierless_train<outlierless_train>  Path to training data with no outliers
--outlierless_test<outlierless_test>    Path to testing data with no outliers
--lin_fit=<lin_fit>                     Linear regression model data
" -> doc

suppressMessages(library(tidyverse))
suppressMessages(library(tidymodels))
suppressWarnings(library(docopt))

opt <- docopt(doc)

main <- function(test_data, outlierless_train, outlierless_test, lin_fit) {
  
  # Read test data
  test_df <- read_csv(test_data)
  
  # Read linear regression model
  lm_fit <- readRDS(lin_fit)
  
  # Make and store the linear model scores table
  lm_test_scores_table <- lm_fit |>
    metrics(truth = fatalities, estimate = .pred)
  
  write_csv(lm_test_scores_table, 
            file.path("results/02_linear_model_test_scores_table.csv"))
  
  # Draw linear model onto graphs
  fatal_predictions <- lm_fit |>
    predict(test_df) |>
    bind_cols(test_df)
  
  y_intercept <- tidy(lm_fit) |>
    filter(term == "(Intercept)") |>
    select(estimate) |>
    pull()
  
  tornado_length <- tidy(lm_fit) |>
    filter(term == "length") |>
    select(estimate) |>
    pull()
  
  tornado_width <- tidy(lm_fit) |>
    filter(term == "width") |>
    select(estimate) |>
    pull()
  
  options(repr.plot.width = 8, repr.plot.height = 7)
  
  # Create and store scatter plot comparing accuracy of the linear model
  ## Note: Red line represents where points would be plotted if the model was 100% accurate
  fatal_model_viz <- ggplot(fatal_predictions, aes(x = fatalities, y = .pred)) +
    geom_point(alpha = 0.6) +
    geom_abline(intercept = 0, slope = 1, color = "red", linetype = "dashed", linewidth = 2)+
    scale_x_continuous(trans = "log10") + 
    xlab("Actual Number of Fatalities") +
    ylab("Predicted Number of Fatalities") +
    ggtitle("Actual Number of Fatalities vs Predicted Number of Fatalities") +
    theme(text = element_text(size = 14), plot.title = element_text(hjust = 0.5))
  
  ggsave("results/03_actual_vs_predicted_fatalities_plot.png", fatal_model_viz)
  
  # Create and store scatter plot for tornado width with linear regression line
  ## Note: Blue line represents predicted values based on our regression model when tornado length = 0
  fatal_widths_plot <- ggplot(test_df, aes(x = width, y = fatalities)) +
    geom_point(alpha = 0.4) +
    geom_abline(intercept = y_intercept, slope = tornado_width, color = "steelblue", linewidth = 2) +
    scale_y_continuous(trans = "log10") + 
    xlab("Tornado Width (Yards)") +
    ylab("Fatalities") +
    ggtitle("Fatalities vs Width Plot") +
    theme(text = element_text(size = 15), plot.title = element_text(hjust = 0.5))
  
  ggsave("results/04_fatalities_vs_width_plot.png", fatal_widths_plot)
  
  # Create and store scatter plot for tornado length with linear regression line
  ## Note: Blue line represents predicted values based on our regression model when tornado width = 0
  fatal_length_plot <- ggplot(test_df, aes(x = length, y = fatalities)) +
    geom_point(alpha = 0.4) +
    geom_abline(intercept = y_intercept, slope = tornado_length, color = "steelblue", linewidth = 2) +
    scale_y_continuous(trans = "log10") + 
    xlab("Tornado Length (Miles)") +
    ylab("Fatalities") +
    ggtitle("Fatalities vs Length Plot") +
    theme(text = element_text(size = 15), plot.title = element_text(hjust = 0.5))
  
  ggsave("results/05_fatalities_vs_length_plot.png", fatal_length_plot)
  
  # Create and store boxplot for tornado widths
  width_boxplot <- ggplot(test_df, aes(y = width)) +
    geom_boxplot() +
    ggtitle("Boxplot of Tornado Widths") +
    labs(x = "Tornado Width (Yards)", y = "Values")

  ggsave("results/06_width_outlier_boxplot.png", width_boxplot)

  # Create and store boxplot for tornado lengths
  height_boxplot <- ggplot(test_df, aes(y = length)) +
    geom_boxplot() +
    ggtitle("Boxplot of Tornado Lengths") +
    labs(x = "Tornado Length (Miles)", y = "Values")
  
  ggsave("results/07_length_outlier_boxplot.png", length_boxplot)

  # Create and store boxplot for tornado fatalities
  fatalities_boxplot <- ggplot(test_df, aes(y = fatalities)) +
    geom_boxplot() +
    ggtitle("Boxplot of Tornado Fatalities") +
    labs(x = "Number of Fatalities", y = "Values")
  
  ggsave("results/08_fatalities_outlier_boxplot.png", fatalities_boxplot)
  
  ############
  ############ The following could be added to script_4 as the code is identical
  
  # Reading the outlierless training data
  train_data <- read_csv(outlierless_train)
  
  # Create linear model and recipe
  lm_spec <- linear_reg() %>%
    set_engine("lm") %>%
    set_mode("regression")
  
  lm_recipe <- recipe(fatalities ~ width + length, data = train_data)
  
  # Fit linear model and save to RDS
  outlierless_lm_fit <- workflow() %>%
    add_recipe(lm_recipe) %>%
    add_model(lm_spec) %>%
    fit(data = train_data)
  
  ############
  ############
  
  # Read the outlierless testing data
  outlierless_test_df  <- read.csv(outlierless_test)
  
  # Make and store the linear model scores table
  outlierless_lm_test_scores_table <- outlierless_lm_fit |>
    metrics(truth = fatalities, estimate = .pred)
  
  write_csv(outlierless_lm_test_scores_table, 
            file.path("results/09_linear_model_test_scores_without_outliers_table.csv"))
  
  # Draw linear model onto graphs without outliers
  outlierless_fatal_predictions <- lm_fit |>
    predict(outlierless_test_df) |>
    bind_cols(outlierless_test_df)
  
  outlierless_intercept <- tidy(outlierless_lm_fit) |>
    filter(term == "(Intercept)") |>
    select(estimate) |>
    pull()
  
  outlierless_tornado_length <- tidy(outlierless_lm_fit) |>
    filter(term == "length") |>
    select(estimate) |>
    pull()
  
  outlierless_tornado_width <- tidy(outlierless_lm_fit) |>
    filter(term == "width") |>
    select(estimate) |>
    pull()
  
  # Create and store scatter plot comparing accuracy of the linear model without outliers
  ## Note: Red line represents where points would be plotted if the model was 100% accurate
  outlierless_model_viz <- ggplot(outlierless_fatal_predictions, aes(x = fatalities, y = .pred)) +
    geom_point(alpha = 0.6) +
    geom_abline(intercept = 0, slope = 1, color = "red", linetype = "dashed", linewidth = 2)+
    scale_x_continuous(trans = "log10") + 
    xlab("Actual Number of Fatalities") +
    ylab("Predicted Number of Fatalities") +
    ggtitle("Actual Number of Fatalities vs Predicted Number of Fatalities") +
    theme(text = element_text(size = 14), plot.title = element_text(hjust = 0.5))
  
  ggsave("results/10_actual_vs_predicted_fatalities_plot_no_outliers.png", outlierless_model_viz)
  
  # Create and store scatter plot for tornado width with linear regression line
  ## Note: Blue line represents predicted values based on our regression model when tornado length = 0
  outlierless_widths_plot <- ggplot(outlierless_test_df, aes(x = width, y = fatalities)) +
    geom_point(alpha = 0.4) +
    geom_abline(intercept = outlierless_intercept, slope = outlierless_tornado_width, color = "steelblue", linewidth = 2) +
    scale_y_continuous(trans = "log10") + 
    xlab("Tornado Width (Yards)") +
    ylab("Fatalities") +
    ggtitle("Fatalities vs Width Plot") +
    theme(text = element_text(size = 15), plot.title = element_text(hjust = 0.5))
  
  ggsave("results/11_fatalities_vs_width_plot_no_outliers.png", outlierless_widths_plot)
  
  # Create and store scatter plot for tornado length with linear regression line
  ## Note: Blue line represents predicted values based on our regression model when tornado width = 0
  outlierless_length_plot <- ggplot(outlierless_test_df, aes(x = length, y = fatalities)) +
    geom_point(alpha = 0.4) +
    geom_abline(intercept = outlierless_intercept, slope = outlierless_tornado_length, color = "steelblue", linewidth = 2) +
    scale_y_continuous(trans = "log10") + 
    xlab("Tornado Length (Miles)") +
    ylab("Fatalities") +
    ggtitle("Fatalities vs Length Plot") +
    theme(text = element_text(size = 15), plot.title = element_text(hjust = 0.5))
  
  ggsave("results/12_fatalities_vs_length_plot_no_outliers.png", outlierless_length_plot)
}

main(opt$test_data, opt$outlierless_train, opt$outlierless_test, opt$lin_fit)