"This script creates takes the test data and linear regression model and uses
them to create scatterplots used to assess the accuracy of the regression model.
Additionally, this script creates boxplots from the test data to assess the 
outliers in the data set.

Usage: src/05_linear_model_results.R --test_data=<test_data> --outlierless_test=<outlierless_test> --lin_fit=<lin_fit> --lin_fit_outlierless=<lin_fit_outlierless> --output_path=<output_path>

Options:
--test_data=<test_data>                       Path to the test data
--outlierless_test=<outlierless_test>         Path to testing data with no outliers
--lin_fit=<lin_fit>                           Linear regression model object for complete data 
--lin_fit_outlierless=<lin_fit_outlierless>   Linear regression model object for outlierless data
--output_path=<output_path>                   Path to the outputs 
" -> doc

suppressMessages(library(tidyverse))
suppressMessages(library(tidymodels))
suppressWarnings(library(docopt))
source("R/accuracy_plot.R")
source("R/create_scatterplot.R")
source("R/boxplot_viz.R")

opt <- docopt(doc)

boxplots <- function(test_data, output_path) {
  # Create and store boxplot for tornado widths
  width_boxplot <- boxplot_viz(test_data, width) +
    ggtitle("Boxplot of Tornado Widths") +
    labs(x = "Tornado Width (Yards)", y = "Values")

  ggsave(file.path(output_path, "07_width_outlier_boxplot.png"), width_boxplot)

  # Create and store boxplot for tornado lengths
  length_boxplot <- boxplot_viz(test_data, length) +
    ggtitle("Boxplot of Tornado Lengths") +
    labs(x = "Tornado Length (Miles)", y = "Values")
  
  ggsave(file.path(output_path, "08_length_outlier_boxplot.png"), length_boxplot)

  # Create and store boxplot for tornado fatalities
  fatalities_boxplot <- boxplot_viz(test_data, fatalities) +
    ggtitle("Boxplot of Tornado Fatalities") +
    labs(x = "Number of Fatalities", y = "Values")
  
  ggsave(file.path(output_path, "09_fatalities_outlier_boxplot.png"), fatalities_boxplot)
}






outlier_plots <- function(test_data, predictions, intercept, tornado_length, tornado_width, output_path) {
    # Create and store scatter plot comparing accuracy of the linear model
  ## Note: Red line represents where points would be plotted if the model was 100% accurate
  fatal_model_viz <- accuracy_plot(predictions, fatalities) +
    xlab("Actual Number of Fatalities") +
    ylab("Predicted Number of Fatalities") +
    ggtitle("Actual Number of Fatalities vs Predicted Number of Fatalities")
  
  ggsave(file.path(output_path, "04_actual_vs_predicted_fatalities_plot.png"), fatal_model_viz)
  
  # Create and store scatter plot for tornado width with linear regression line
  ## Note: Blue line represents predicted values based on our regression model when tornado length = 0
  fatal_widths_plot <- create_scatterplot(test_data, width, fatalities) +
    geom_abline(aes(intercept = intercept, slope = tornado_width, linetype = "Regression Line"), 
                    color = "steelblue", linewidth = 2) +
    scale_y_continuous(trans = "log10") + 
    xlab("Tornado Width (Yards)") +
    ylab("Fatalities") +
    ggtitle("Fatalities vs Width Plot")
  
  ggsave(file.path(output_path, "05_fatalities_vs_width_plot.png"), fatal_widths_plot)
  
  # Create and store scatter plot for tornado length with linear regression line
  ## Note: Blue line represents predicted values based on our regression model when tornado width = 0
fatal_length_plot <- create_scatterplot(test_data, length, fatalities) +
    geom_abline(aes(intercept = intercept, slope = tornado_length, linetype = "Regression Line"),
                    color = "steelblue", linewidth = 2) +
    scale_y_continuous(trans = "log10") + 
    xlab("Tornado Length (Miles)") +
    ylab("Fatalities") +
    ggtitle("Fatalities vs Length Plot")

  ggsave(file.path(output_path, "06_fatalities_vs_length_plot.png"), fatal_length_plot)
}




outlierless_plots <- function(test_data, predictions, intercept, tornado_length, tornado_width, output_path) {
    # Create and store scatter plot comparing accuracy of the linear model without outliers
  ## Note: Red line represents where points would be plotted if the model was 100% accurate
  outlierless_model_viz <- accuracy_plot(predictions, fatalities) +
    xlab("Actual Number of Fatalities") +
    ylab("Predicted Number of Fatalities") +
    ggtitle("Actual Number of Fatalities vs Predicted Number of Fatalities")
  
  ggsave(file.path(output_path, "11_actual_vs_predicted_fatalities_plot_no_outliers.png"), outlierless_model_viz)
  
  # Create and store scatter plot for tornado width with linear regression line
  ## Note: Blue line represents predicted values based on our regression model when tornado length = 0
  outlierless_widths_plot <- create_scatterplot(test_data, width, fatalities) +
    geom_abline(aes(intercept = intercept, slope = tornado_width, linetype = "Regression Line"), 
                color = "steelblue", linewidth = 2) +
    scale_y_continuous(trans = "log10") +
    xlab("Tornado Width (Yards)") +
    ylab("Fatalities") +
    ggtitle("Fatalities vs Width Plot")
  
  ggsave(file.path(output_path, "12_fatalities_vs_width_plot_no_outliers.png"), outlierless_widths_plot)
  
  # Create and store scatter plot for tornado length with linear regression line
  ## Note: Blue line represents predicted values based on our regression model when tornado width = 0
  outlierless_length_plot <- create_scatterplot(test_data, length, fatalities) +
    geom_abline(aes(intercept = intercept, slope = tornado_length, linetype = "Regression Line"), 
                color = "steelblue", linewidth = 2) +
    scale_y_continuous(trans = "log10") +
    xlab("Tornado Length (Miles)") +
    ylab("Fatalities") +
    ggtitle("Fatalities vs Length Plot")
  
  ggsave(file.path(output_path, "13_fatalities_vs_length_plot_no_outliers.png"), outlierless_length_plot)
}



main <- function(test_data, outlierless_test, lin_fit, lin_fit_outlierless, output_path) {

  # Read test data
  test_df <- read_csv(test_data)

  # Read linear regression model
  lm_fit <- readRDS(lin_fit)

  # Make and store the linear model scores table
  lm_test_scores_table <- lm_fit |>
    predict(test_df) |>
    bind_cols(test_df) |>
    metrics(truth = fatalities, estimate = .pred)

  write_csv(lm_test_scores_table, 
            file.path(output_path, "03_linear_model_test_scores_table.csv"))

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

  # Make relevant scatterplots for data with outliers
  outlier_plots(test_df,
                fatal_predictions,
                y_intercept,
                tornado_length,
                tornado_width,
                output_path)

  # Make boxplots for data with outliers
  boxplots(test_df, output_path)

  # Read the outlierless testing data
  outlierless_test_df  <- read.csv(outlierless_test)

  # Read linear regression model
  outlierless_lm_fit <- readRDS(lin_fit_outlierless)

  # Make and store the linear model scores table
  outlierless_lm_test_scores_table <- outlierless_lm_fit |>
    predict(outlierless_test_df) |>
    bind_cols(outlierless_test_df) |>
    metrics(truth = fatalities, estimate = .pred)

  write_csv(outlierless_lm_test_scores_table, 
            file.path(output_path, "10_linear_model_test_scores_without_outliers_table.csv"))

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

  # Make relevant scatterplots for outlierless test data
  outlierless_plots(outlierless_test_df,
                    outlierless_fatal_predictions,
                    outlierless_intercept,
                    outlierless_tornado_length,
                    outlierless_tornado_width,
                    output_path)
  
  # # Create and store scatter plot comparing accuracy of the linear model without outliers
  # ## Note: Red line represents where points would be plotted if the model was 100% accurate
  # outlierless_model_viz <- accuracy_plot(outlierless_fatal_predictions, fatalities) +
  #   xlab("Actual Number of Fatalities") +
  #   ylab("Predicted Number of Fatalities") +
  #   ggtitle("Actual Number of Fatalities vs Predicted Number of Fatalities")
  
  # ggsave(file.path(output_path, "11_actual_vs_predicted_fatalities_plot_no_outliers.png"), outlierless_model_viz)
  
  # # Create and store scatter plot for tornado width with linear regression line
  # ## Note: Blue line represents predicted values based on our regression model when tornado length = 0
  # outlierless_widths_plot <- create_scatterplot(outlierless_test_df, width, fatalities) +
  #   geom_abline(intercept = outlierless_intercept, slope = outlierless_tornado_width, color = "steelblue", linewidth = 2) +
  #   scale_y_continuous(trans = "log10") + 
  #   xlab("Tornado Width (Yards)") +
  #   ylab("Fatalities") +
  #   ggtitle("Fatalities vs Width Plot")
  
  # ggsave(file.path(output_path, "12_fatalities_vs_width_plot_no_outliers.png"), outlierless_widths_plot)
  
  # # Create and store scatter plot for tornado length with linear regression line
  # ## Note: Blue line represents predicted values based on our regression model when tornado width = 0
  # outlierless_length_plot <- create_scatterplot(outlierless_test_df, length, fatalities) +
  #   geom_abline(intercept = outlierless_intercept, slope = outlierless_tornado_length, color = "steelblue", linewidth = 2) +
  #   scale_y_continuous(trans = "log10") + 
  #   xlab("Tornado Length (Miles)") +
  #   ylab("Fatalities") +
  #   ggtitle("Fatalities vs Length Plot")
  
  # ggsave(file.path(output_path, "13_fatalities_vs_length_plot_no_outliers.png"), outlierless_length_plot)
}

main(opt$test_data, opt$outlierless_test, opt$lin_fit, opt$lin_fit_outlierless, opt$output_path)