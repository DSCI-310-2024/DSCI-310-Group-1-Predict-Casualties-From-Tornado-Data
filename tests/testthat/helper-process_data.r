# function inputs for tests for clean_data
correct_df <- data.frame(
  om = c(156, 189, 26), 
  yr = c(1950, 1951, 1952), 
  mo = c(10, 11, 12), 
  dy = c(1, 9, 20), 
  date = as.Date(c("2021-03-26", "2022-03-26", "2024-03-01")),
  time = as.POSIXct(c("12:00:00", "13:00:00", "21:00:00"), format = "%H:%M:%S"),
  tz = c("America/Chicago", "America/Chicago", "America/Chicago"),
  datetime_utc = as.POSIXct(c("2021-03-26 12:00:00", "2022-03-26 13:00:00", "2024-03-01 21:00:00")),
  st = c("OK", "NC", "TX"),
  stf = c(0, 0, 0), 
  mag = c(0, 0, NA), 
  inj = c(0, 0, 0), 
  fat = c(0, 0, 0), 
  loss = c(0, 0, 0), 
  slat = c(0, 0, 0), 
  slon = c(0, 0, 0), 
  elat = c(0, 0, 0), 
  elon = c(0, -50, -60), 
  len = c(0, 0, 0), 
  wid = c(0, 0, 0), 
  ns = c(0, 0, NA), 
  sn = c(0, 0, 0), 
  f1 = c(0, 0, 0), 
  f2 = c(0, 0, 0), 
  f3 = c(0, 0, NA), 
  f4 = c(0, 0, 0), 
  fc = c(FALSE, FALSE, TRUE)
)


incorrect_wrong_column_ordering <- data.frame(
  stf = c(0, 0, 0), 
  mag = c(0, 0, 0), 
  inj = c(0, 0, 0), 
  fat = c(0, 0, 0), 
  loss = c(0, 0, 0), 
  slat = c(0, 0, 0), 
  slon = c(0, 0, 0), 
  elat = c(0, 0, 0), 
  elon = c(0, -50, -60), 
  len = c(0, 0, 0), 
  wid = c(0, 0, 0), 
  ns = c(0, 0, 0), 
  sn = c(0, 0, 0), 
  f1 = c(0, 0, 0), 
  f2 = c(0, 0, 0), 
  f3 = c(0, 0, NA), 
  f4 = c(0, 0, 0), 
  fc = c(FALSE, FALSE, TRUE),
  om = c(156, 189, 26), 
  yr = c(1950, 1951, 1952), 
  mo = c(10, 11, 12), 
  dy = c(1, 9, 20), 
  date = as.Date(c("2021-03-26", "2022-03-26", "2024-03-01")),
  time = as.POSIXct(c("12:00:00", "13:00:00", "21:00:00"), format = "%H:%M:%S"),
  tz = c("America/Chicago", "America/Chicago", "America/Chicago"),
  datetime_utc = as.POSIXct(c("2021-03-26 12:00:00", "2022-03-26 13:00:00", "2024-03-01 21:00:00")),
  st = c("OK", "NC", "TX")
)


incorrect_missing_columns <- data.frame(
  om = c(156, 189, 26), 
  yr = c(1950, 1951, 1952), 
  mo = c(10, 11, 12)
)


incorrect_wrong_type <- list(
  om = c(156, 189, 26), 
  yr = c(1950, 1951, 1952), 
  mo = c(10, 11, 12), 
  dy = c(1, 9, 20), 
  date = as.Date(c("2021-03-26", "2022-03-26", "2024-03-01")),
  time = as.POSIXct(c("12:00:00", "13:00:00", "21:00:00"), format = "%H:%M:%S"),
  tz = c("America/Chicago", "America/Chicago", "America/Chicago"),
  datetime_utc = as.POSIXct(c("2021-03-26 12:00:00", "2022-03-26 13:00:00", "2024-03-01 21:00:00")),
  st = c("OK", "NC", "TX"),
  stf = c(0, 0, 0), 
  mag = c(0, 0, NA), 
  inj = c(0, 0, 0), 
  fat = c(0, 0, 0), 
  loss = c(0, 0, 0), 
  slat = c(0, 0, 0), 
  slon = c(0, 0, 0), 
  elat = c(0, 0, 0), 
  elon = c(0, -50, -60), 
  len = c(0, 0, 0), 
  wid = c(0, 0, 0), 
  ns = c(0, 0, NA), 
  sn = c(0, 0, 0), 
  f1 = c(0, 0, 0), 
  f2 = c(0, 0, 0), 
  f3 = c(0, 0, NA), 
  f4 = c(0, 0, 0), 
  fc = c(FALSE, FALSE, TRUE)
)


# expected function output
correct_df_output <- data.frame(
  ID = c(156, 189), 
  year = c(1950, 1951), 
  month = c(10, 11), 
  day = c(1, 9), 
  time = as.POSIXct(c("12:00:00", "13:00:00"), format = "%H:%M:%S"),
  datetime_utc = as.POSIXct(c("2021-03-26 12:00:00", "2022-03-26 13:00:00")),
  state = c("OK", "NC"),
  mag = c(0, 0), 
  injuries = c(0, 0), 
  fatalities = c(0, 0), 
  start_lat = c(0, 0), 
  start_lon = c(0, 0), 
  end_lat = c(0, 0), 
  end_lon = c(0, -50), 
  length = c(0, 0), 
  width = c(0, 0), 
  ns = c(0, 0) 
)