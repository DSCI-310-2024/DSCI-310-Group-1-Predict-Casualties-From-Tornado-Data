# author: Group 1

"This script reads the raw data and performs any necessary preprocessing
before the exploratory data analysis or modelling takes place. It also
splits the processed data into train and test sets.

Usage: src/02_clean_preprocess_data.R --raw_data=<raw_data> --data_to=<data_to> [--seed=<seed>]

Options:
--raw_data=<raw_data>   Path to the raw data
--data_to=<data_to>     Path to the directory where you want to save all processed data files
--seed=<seed>           Set a specified seed, by default will be set at 2000 [default: 2000]
" -> doc

suppressMessages(library(tidyverse))
suppressWarnings(library(docopt))
suppressMessages(library(repr))
suppressMessages(library(tidymodels))
suppressMessages(library(psych))
suppressMessages(library(GGally))

opt <- docopt(doc)

main <- function(raw_data, data_to, seed) {

    # read raw data
    data <- read_csv(raw_data)

    # remove irrelevant or repetitive columns; filter for NA in magnitude
    clean_data <- data %>%
    select(-date, -tz, -stf, -sn, -f1, -f2, -f3, -f4, -fc, -loss) %>%
    filter(!is.na(mag))

    # change feature names to be more descriptive
    names(clean_data) <- c('ID','year','month','day','time','datetime_utc','state','mag','injuries',
                  'fatalities','start_lat','start_lon','end_lat','end_lon','length','width','ns')
    
    # save processed dataset to specified directory/filepath
    write_csv(clean_data, file.path(data_to, "01_processed_tornado_data.csv"))

    

    # split the processed data into training and testing set
    set.seed(seed)

    data_split <- initial_split(clean_data, prop = 0.75, strata = fatalities)
    train_df <- training(data_split)
    test_df <- testing(data_split)

    # save training and testing sets to specified directory/filepath
    write_csv(train_df, file.path(data_to, "02_tornado_train_data.csv"))
    write_csv(test_df, file.path(data_to, "03_tornado_test_data.csv"))



    # find first and third quartiles for tornado length and width
    length_quartiles <- quantile(clean_data$length, probs = c(0.25, 0.75))
    width_quartiles <- quantile(clean_data$width, probs = c(0.25, 0.75))
  
    # find interquartile range for tornado length and width
    length_IQR <- IQR(clean_data$length)
    width_IQR <- IQR(clean_data$width)
  
    # find fences for width and length
    width_upper_fence <- width_quartiles[2] + (1.5 * width_IQR)
    width_lower_fence <- width_quartiles[1] - (1.5 * width_IQR)
    length_upper_fence <- length_quartiles[2] + (1.5 * length_IQR)
    length_lower_fence <- length_quartiles[1] - (1.5 * length_IQR)
  
    # create and save dataframe containing no ourliers to a specified filepath
    outlierless_df <- clean_data |>
        filter(width < width_upper_fence) |>
        filter(width > width_lower_fence) |>
        filter(length < length_upper_fence) |>
        filter(length > length_lower_fence)
  
    write.csv(outlierless_df, file.path(data_to, "tornado_outlierless.csv"))
  


  
    # split save outlierless data into training and testind data to designated filepaths
    outlierless_data_split <- initial_split(clean_data, prop = 0.75, strata = fatalities)
    outlierless_train_df <- training(outlierless_data_split)
    outlierless_test_df <- testing(outlierless_data_split)
  
    write_csv(outlierless_train_df, file.path(data_to, "tornado_train_outlierless.csv"))
    write_csv(outlierless_test_df, file.path(data_to, "tornado_test_outlierless.csv"))
}

main(opt$raw_data, opt$data_to, opt$seed)