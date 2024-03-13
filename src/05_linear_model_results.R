"This script reads the raw data and performs any necessary preprocessing
before the exploratory data analysis or modelling takes place. It also
splits the processed data into train and test sets.

Usage: 05_linear_model_results.R --test_data=<test_data> --data_to=<data_to>

Options:
--test_data=<test_data>   Path to the test data
--data_to=<data_to>       Path to the directory where you want to save all processed data files
" -> doc

library(tidyverse)
library(tidymodels)
library(docopt)

opt <- docopt(doc)

main <- function(test_data, lm_fit) {
  
  # Read test data
  test_df <- read_csv(test_data)
  
  
  # Make and store the linear model scores table
  lm_test_scores_table <- lm_fit |>
    metrics(truth = fatalities, estimate = .pred)
  
  write_csv(lm_test_scores_table, 
            file.path("results/02_linear_model_test_scores.csv"))
  
  # Draw linear model onto graphs
  fatal_predictions <- lm_fit |>
    predict(test_df) |>
    bind_cols(test_df)
  
  options(repr.plot.width = 8, repr.plot.height = 7)
  
  # Create and store scatter plot comparing accuracy of the linear model
  ## Note: Red line represents where points would be plotted if the model was 100% accurate
  fatal_model_viz <- ggplot(fatal_predictions, aes(x = fatalities, y = .pred)) +
    geom_point(alpha = 0.6) +
    geom_abline(intercept = 0, slope = 1, color = "red", linetype = "dashed", linewidth = 2)+
    scale_x_continuous(trans = "log10") + 
    xlab("Actual Number of Fatalities") +
    ylab("Predicted Number of Fatalities") +
    ggtitle("Figure 4: Actual Number of Fatalities vs Predicted Number of Fatalities") +
    theme(text = element_text(size = 14), plot.title = element_text(hjust = 0.5))
  
  ggsave("results/03_actual_vs_predicted_fatalities_plot.png", fatal_model_viz)
  
  # Create and store scatter plot for tornado width with linear regression line
  ## Note: Blue line represents predicted values based on our regression model when tornado length = 0
  fatal_widths_plot <- ggplot(test_df, aes(x = width, y = fatalities)) +
    geom_point(alpha = 0.4) +
    geom_abline(intercept = -0.1183680, slope = 0.0007337, color = "steelblue", linewidth = 2) +
    scale_y_continuous(trans = "log10") + 
    xlab("Tornado Width (Yards)") +
    ylab("Fatalities") +
    ggtitle("Figure 5: Fatalities vs Width Plot") +
    theme(text = element_text(size = 15), plot.title = element_text(hjust = 0.5))
  
  ggsave("results/04_fatalities_vs_width_plot.png", fatal_widths_plot)
  
  # Create and store scatter plot for tornado length with linear regression line
  ## Note: Blue line represents predicted values based on our regression model when tornado width = 0
  fatal_length_plot <- ggplot(test_df, aes(x = length, y = fatalities)) +
    geom_point(alpha = 0.4) +
    geom_abline(intercept = -0.1183680, slope = 0.0367960, color = "steelblue", linewidth = 2) +
    scale_y_continuous(trans = "log10") + 
    xlab("Tornado Length (Miles)") +
    ylab("Fatalities") +
    ggtitle("Figure 6: Fatalities vs Length Plot") +
    theme(text = element_text(size = 15), plot.title = element_text(hjust = 0.5))
  
  ggsave("results/04_fatalities_vs_length_plot.png", fatal_length_plot)
  
  # # Create and store boxplot for tornado widths
  # width_boxplot <- boxplot(test_df$width, main = "Boxplot of Tornado Widths", 
  #                           ylab = "Values", xlab = "Tornado Width (Yards)")
  # 
  # 
  # # Create and store boxplot for tornado lengths
  # height_boxplot <- boxplot(test_df$length, main = "Boxplot of Tornado Lengths", 
  #                            ylab = "Values", xlab = "Tornado Length (Miles)")
  # 
  # # Create and store boxplot for tornado fatalities
  # fatalities_boxplot <- boxplot(test_df$fatalities, main = "Boxplot of Tornado Fatalities", 
  #                               ylab = "Values", xlab = "Number of Fatalities")
  
  
}

main(opt$raw_data, opt$data_to, opt$seed)