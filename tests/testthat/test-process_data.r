library(testthat)
source("../../R/process_data.R")

test_that("`clean_data` should return a data frame or data frame extension with no NA values, and 17 columns named from
          left to right: ID, year, month, day, time, datetime_utc, state, mag, injuries, fatalities, start_lat,
          start_lon, end_lat, end_lon, length, width, ns", {
  expect_equivalent(process_data(correct_df), correct_df_output)
})

test_that("`clean_data` should throw an error when incorrect types are passed to `data_frame` argument", {
  expect_error(process_data(incorrect_wrong_type))
})

test_that("`clean_data` should throw an error when data frame does not contain all original columns in raw data
          in this order: om, yr, mo, dy, date, time, tz, datetime_utc, st, stf, mag, inj, fat, loss, slat, slon,
          elat, elon, len, wid, ns, sn, f1, f2, f3, f4, fc", {
  expect_error(process_data(incorrect_wrong_column_ordering))
  expect_error(process_data(incorrect_missing_columns))
})
