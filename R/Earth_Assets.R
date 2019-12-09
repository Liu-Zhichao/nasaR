#' Earth_Assets: The date-times and asset names for available imagery for a supplied location
#'
#' This function retrieves retrieves the date-times and asset names for available imagery for a supplied location.
#' The satellite passes over each point on earth roughly once every sixteen days.
#' This is an amazing visualization of the acquisition pattern for Landsat 8 imagery.
#'
#' @param key String. Your NASA API key, you can enter your key in the function parameter, but it's not recommended. Instead, you'd better save your key in R environment and call it "NASA_TOKEN". Then the function would automatically acquire your key info.
#' @param lat Float. Latitude of the location.
#' @param lon Float. Longitude of the location.
#' @param begin_date Date. Beginning of date range.
#' @param end_date Date. End of date range. Today as default.
#' @return A dataframe including date-times and asset names.
#' @examples
#' Earth_Assets(lon = 100.75, lat = 1.5, begin_date = as.Date("2014-02-01"))
#' @export
Earth_Assets <- function(key = Sys.getenv("NASA_TOKEN"), lat, lon, begin_date, end_date = Sys.Date()){
  library(tidyr)
  library(httr)
  library(dplyr)
  response <- "https://api.nasa.gov/planetary/earth/assets?" %>%
    paste(., "lon=", lon, "&lat=", lat, "&begin=", begin_date, "&end=", end_date, "&api_key=", key, sep = "") %>%
    GET(.)
  if (response$status_code != 200){
    message("Unsuccessful status of response!")
  }
  result <- content(response)$results
  final <- lapply(result, data.frame, stringsAsFactors = FALSE) %>%
    bind_rows(.)
  return(final)
}
