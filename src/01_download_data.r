# author: Group 1

"This script downloads the data from a specified URL and saves it to a specified local filepath.

Usage: Rscript src/01_download_data.R --url=<url> 

Options:
--url=<url>               URL of the dataset location from the web or local file path
" -> doc

suppressMessages(library(tidyverse))
suppressWarnings(library(docopt))

opt <- docopt(doc)

main <- function(url) {

    # read in data from web
    data <- read_csv(url)

    # save the file in specified local filepath
    write_csv(data, 'data/raw/raw_tornado_data.csv')
}

main(opt$url)
