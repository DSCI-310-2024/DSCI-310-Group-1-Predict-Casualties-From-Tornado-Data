# author: Group 1

"This script downloads the data from a specified URL and saves it to a specified local filepath.

Usage: src/01_download_data.R --url=<url> --file_path=<file_path>

Options:
--url=<url>               URL of the dataset location from the web or local file path
--file_path=<file_path>   The local filepath where you want to save the file and what to name it
" -> doc

suppressMessages(library(tidyverse))
suppressWarnings(library(docopt))

opt <- docopt(doc)

main <- function(url, file_path) {

    # read in data from web
    # https://raw.githubusercontent.com/rfordatascience/tidytuesday/a9e277dd77331e9091e151bb5adb584742064b3e/data/2023/2023-05-16/tornados.csv 
    data <- read_csv(url)

    # save the file in specified local filepath
    write_csv(data, file_path)
}

main(opt$url, opt$file_path)
