#' DONKI_Notifications: Space Weather Database Of Notifications, Knowledge, Information - Notifications
#'
#' Get access to the data of Notifications.
#'
#' @param key String. Your NASA API key, you can enter your key in the function parameter, but it's not recommended. Instead, you'd better save your key in R environment and call it "NASA_TOKEN". Then the function would automatically acquire your key info.
#' @param start_date Date. Starting UTC date for Notifications search. 7 days prior to current UTC date as default. The request date range is limit to 30 days. If the request range is greater than 30 days, it would limit your request range to (end_date-30) to end_date.
#' @param end_date Date. Ending UTC date for Notifications search. Current UTC date as default.
#' @param type String. "all" as default (choices: "all", "FLR", "SEP", "CME", "IPS", "MPC", "GST", "RBE", "report")
#' @return Data of Notifications.
#' @examples
#' DONKI_Notifications(start_date = as.Date("2019-01-01"), end_date = as.Date("2019-03-01"))
#' @export
DONKI_Notifications <- function(key = Sys.getenv("NASA_TOKEN"), start_date = end_date - 7, end_date = lubridate::today(tzone = "UTC"), type = "all"){
  library(tidyr)
  library(httr)
  time_diff <- as.numeric(end_date - start_date)
  if (time_diff > 30){
    start_date <- end_date - 30
  }
  response <- "https://api.nasa.gov/DONKI/notifications?" %>%
    paste(., "startDate=", start_date, "&endDate=", end_date, "&type=", type, "&api_key=", key, sep = "") %>%
    GET(.)
  if (response$status_code != 200){
    message("Unsuccessful status of response!")
  }
  result <- content(response)
  return(result)
}
