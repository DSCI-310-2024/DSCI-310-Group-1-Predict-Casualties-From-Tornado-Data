#' Process Data
#'
#' Removes NA values in `mag` variable and repetitive/irrelevant columns from data frame; renames column names
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
  if (!is.data.frame(data_frame)) {
    stop("`data_frame` should be a data frame or data frame extension (e.g. a tibble)")
  }
  
  
  exact_original_columns <- c("om", "yr", "mo", "dy", "date", "time", "tz", 
                              "datetime_utc", "st", "stf", "mag", "inj", "fat", "loss", 
                              "slat", "slon", "elat", "elon", "len", "wid", 
                              "ns", "sn", "f1", "f2", "f3", "f4", "fc")
  if(!identical(names(data_frame), exact_original_columns)) {
    stop("ensure `data_frame` contains all 27 columns in original dataset in EXACT ORDERING AND NAMING AS FOLLOWS:
         om, yr, mo, dy, date, time, tz, datetime_utc, st, stf, mag, inj, fat, loss, slat, slon,
          elat, elon, len, wid, ns, sn, f1, f2, f3, f4, fc")
  }
  
  
  processed_data <- data_frame %>%
    dplyr::select(-date, -tz, -stf, -sn, -f1, -f2, -f3, -f4, -fc, -loss) %>%
    dplyr::filter(!is.na(mag))
  
  names(processed_data) <- c('ID','year','month','day','time','datetime_utc','state','mag','injuries',
                         'fatalities','start_lat','start_lon','end_lat','end_lon','length','width','ns')
  return(processed_data)
}