#' DONKI_CME: Space Weather Database Of Notifications, Knowledge, Information - Coronal Mass Ejection (CME)
#'
#' Get access to the data of Coronal Mass Ejection (CME).
#'
#' @param key String. Your NASA API key, you can enter your key in the function parameter, but it's not recommended. Instead, you'd better save your key in R environment and call it "NASA_TOKEN". Then the function would automatically acquire your key info.
#' @param start_date Date. Starting UTC date for CME search. 30 days prior to current UTC date as default.
#' @param end_date Date. Ending UTC date for CME search. Current UTC date as default.
#' @return Data of CME.
#' @examples
#' DONKI_CME(end_date = as.Date("2019-11-20"))
#' @export
DONKI_CME <- function(key = Sys.getenv("NASA_TOKEN"), start_date = end_date - 30, end_date = lubridate::today(tzone = "UTC")){
  library(tidyr)
  library(httr)
  response <- "https://api.nasa.gov/DONKI/CME?" %>%
    paste(., "startDate=", start_date, "&endDate=", end_date, "&api_key=", key, sep = "") %>%
    GET(.)
  if (response$status_code != 200){
    message("Unsuccessful status of response!")
  }
  result <- content(response)
  return(result)
}


