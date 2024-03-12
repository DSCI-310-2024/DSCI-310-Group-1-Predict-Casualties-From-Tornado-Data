# author: Group 1

"This script downloads the data from a specified URL and saves it to a specified local filepath.

Usage: 01_download_data.r --url=<url> --file_path=<file_path>

Options:
--url=<url>               URL of the dataset location from the web
--file_path=<file_path>   The local filepath where you want to save the file, and what to name it
" -> doc

library(tidyverse)
library(docopt)

opt <- docopt(doc)

main <- function(url, file_path) {

    # read in data from web
    data <- read_csv(url)

    # save the file in specified local filepath
    write_csv(data, file_path)
}

main(opt$url, opt$file_path)