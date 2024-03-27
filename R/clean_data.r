#' Preprocess Data
#'
#' Removes NA values and repetitive/irrelevant columns from data frame; renames column names
#' in this order given that original columns in dataset are in correct order: ID, year, month, day, time, datetime_utc, state, mag,
#' injuries, fatalities, start_lat, start_lon, end_lat, end_lon, length, width, ns 
#'
#' @param data_frame A data frame or data frame extension
#'
#' @return A data frame with no NA values. Column names should be in this order from left to right: ID, year, month, day, time,
#' datetime_utc, state, mag, injuries, fatalities, start_lat, start_lon, end_lat, end_lon, length, width, ns 
#' 
#' @export
#'
#' @examples
#' process_data(raw_data)
process_data <- function(data_frame){
  # returns a data frame with no NA values and 17 columns
}