# author: Group 1

"This script performs EDA and creates the visualizations and tables for EDA. It contains 4 
functions that create either a visualization or a table. One main function runs all other 
functions.

Usage: Rscript src/03_eda.R --file_path=<file_path> 

Options:
--file_path=<file_path>   Path to the data file
" -> doc

# import packages and libraries
library(repr)
library(tidyverse)
library(tidymodels)
library(psych)
library(GGally)
library(docopt)

# parse/define command line arguments 
opt <- docopt(doc)

# create summary table 
create_summary_table <- function(file_path) {
  
    # read in data
    data <- read_csv(file_path)
  
    # create summary table 
    summary_table <- data.frame(describe(data[, c("mag", "injuries", "fatalities", "start_lat", 
                "start_lon", "end_lat", "end_lon", "length", "width", "ns")], fast = TRUE))

    # save table as csv            
    write_csv(summary_table, "results/eda_01_numeric_features_summary_table.csv")
  
}

# create correlation plot
create_correlation_plot <- function(file_path) {
  
    # read in data
    data <- read_csv(file_path)
  
    # create correlation plot 
    options(repr.plot.width = 10, repr.plot.height = 10)

    correlations_plot <- data %>% 
    ggpairs(
        columns = c("mag", "fatalities", "length", "width"), 
        lower = list(
            continuous = "smooth", 
            combo = wrap("facethist", binwidth = 2)), 
        title = "Figure 1: Correlation matrix of important numeral features and target") +
    theme(plot.title = element_text(size = 14, hjust = 0.5)) 
    
    # save plot as image png
    ggsave("results/eda_02_correlation_plot.png", correlations_plot)
 
}

# create scatterplot width vs fatalities
create_scatterplot_width_fatalities <- function(file_path) {
  
    # read in data
    data <- read_csv(file_path)
  
    # create scatterplot 
    options(repr.plot.width = 7, repr.plot.height = 7)

    fatalities_width_scatterplot <- ggplot(data, aes(x = width, y = fatalities)) +
    geom_point(alpha = 0.4) +
    xlab("Width (yards) of tornados") +
    ylab("Fatalities") +
    theme(text = element_text(size = 14), plot.title = element_text(hjust = 0.5)) + 
    ggtitle("Figure 2: Scatterplot of width (yards) of tornado and fatalities")
    
    # save plot as image png
    ggsave("results/eda_03_width_vs_fatalities_scatterplot.png", fatalities_width_scatterplot)
 
}

# create scatterplot length vs fatalities 
create_scatterplot_length_fatalities <- function(file_path) {
  
    # read in data
    data <- read_csv(file_path)
  
    # create scatterplot 
    options(repr.plot.width = 7, repr.plot.height = 7)

    fatalities_length_scatterplot <- ggplot(data, aes(x = length, y = fatalities)) +
    geom_point(alpha = 0.4) +
    xlab("Length (miles) of tornados") +
    ylab("Fatalities") +
    theme(text = element_text(size = 14), plot.title = element_text(hjust = 0.5)) + 
    ggtitle("Figure 3: Scatterplot of length (miles) of tornado and fatalities")
    
    # save plot as image png
    ggsave("results/eda_04_length_vs_fatalities_scatterplot.png", fatalities_length_scatterplot)
}

# main function
main <- function(file_path) {

    # read in data
    data <- read_csv(file_path)

    # create summary table 
    create_summary_table(data)

    # create correlation matrix 
    create_correlation_plot(data)

    # create width vs fatalities scatterplot 
    create_scatterplot_width_fatalities(data)

    # create length vs fatalities scatterplot 
    create_scatterplot_length_fatalities(data)

}

main(opt$file_path)