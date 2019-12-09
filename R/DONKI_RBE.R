#' DONKI_RBE: Space Weather Database Of Notifications, Knowledge, Information - Radiation Belt Enhancement (RBE)
#'
#' Get access to the data of Radiation Belt Enhancement (RBE).
#'
#' @param key String. Your NASA API key, you can enter your key in the function parameter, but it's not recommended. Instead, you'd better save your key in R environment and call it "NASA_TOKEN". Then the function would automatically acquire your key info.
#' @param start_date Date. Starting UTC date for RBE search. 30 days prior to current UTC date as default.
#' @param end_date Date. Ending UTC date for RBE search. Current UTC date as default.
#' @return Data of RBE.
#' @examples
#' DONKI_RBE(start_date = as.Date("2019-01-01"))
#' @export
DONKI_RBE <- function(key = Sys.getenv("NASA_TOKEN"), start_date = end_date - 30, end_date = lubridate::today(tzone = "UTC")){
  library(tidyr)
  library(httr)
  response <- "https://api.nasa.gov/DONKI/RBE?" %>%
    paste(., "startDate=", start_date, "&endDate=", end_date, "&api_key=", key, sep = "") %>%
    GET(.)
  if (response$status_code != 200){
    message("Unsuccessful status of response!")
  }
  result <- content(response)
  return(result)
}
