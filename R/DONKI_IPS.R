#' DONKI_IPS: Space Weather Database Of Notifications, Knowledge, Information - Interplanetary Shock (IPS)
#'
#' Get access to the data of Interplanetary Shock (IPS).
#'
#' @param key String. Your NASA API key, you can enter your key in the function parameter, but it's not recommended. Instead, you'd better save your key in R environment and call it "NASA_TOKEN". Then the function would automatically acquire your key info.
#' @param start_date Date. Starting UTC date for IPS search. 30 days prior to current UTC date as default.
#' @param end_date Date. Ending UTC date for IPS search. Current UTC date as default.
#' @param location String. "ALL" as default (choices: "Earth", "MESSENGER", "STEREO A", "STEREO B").
#' @param catalog String. "ALL" as default (choices: "SWRC_CATALOG", "WINSLOW_MESSENGER_ICME_CATALOG").
#' @return Data of IPS.
#' @examples
#' DONKI_IPS(start_date = as.Date("2019-01-01"), end_date = as.Date("2019-10-31"), location = "Earth")
#' @export
DONKI_IPS <- function(key = Sys.getenv("NASA_TOKEN"), start_date = end_date - 30, end_date = lubridate::today(tzone = "UTC"), location = "ALL", catalog = "ALL"){
  library(tidyr)
  library(httr)
  response <- "https://api.nasa.gov/DONKI/IPS?" %>%
    paste(., "startDate=", start_date, "&endDate=", end_date, "&location=", location, "&catalog=", catalog, "&api_key=", key, sep = "") %>%
    GET(.)
  if (response$status_code != 200){
    message("Unsuccessful status of response!")
  }
  result <- content(response)
  return(result)
}
