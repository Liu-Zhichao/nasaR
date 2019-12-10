#' DONKI_CME: Space Weather Database Of Notifications, Knowledge, Information - Coronal Mass Ejection (CME) Analysis
#'
#' Get access to the data of Coronal Mass Ejection (CME) Analysis.
#'
#' @param key String. Your NASA API key, you can enter your key in the function parameter, but it's not recommended. Instead, you'd better save your key in R environment and call it "NASA_TOKEN". Then the function would automatically acquire your key info.
#' @param start_date Date. Starting UTC date for CME search. 30 days prior to current UTC date as default.
#' @param end_date Date. Ending UTC date for CME search. Current UTC date as default.
#' @param mostAccurateOnly Boolean. TRUE as default.
#' @param completeEntryOnly Boolean. TRUE as default.
#' @param speed Integer. 0 as default.
#' @param halfAngle Integer. 0 as default.
#' @param catalog String. "ALL" as default (choices: "ALL", "SWRC_CATALOG", "JANG_ET_AL_CATALOG").
#' @param keyword String. "NONE" as default (example choices: "swpc_annex").
#' @return Data of CME Analysis.
#' @examples
#' DONKI_CME_Analysis(start_date = as.Date("2016-09-01"), end_date = as.Date("2016-09-30"), speed = 500, halfAngle = 30)
#' @export
DONKI_CME_Analysis <- function(key = Sys.getenv("NASA_TOKEN"), start_date = end_date - 30, end_date = lubridate::today(tzone = "UTC"), mostAccurateOnly = TRUE,
                               completeEntryOnly = TRUE, speed = 0, halfAngle = 0, catalog = "ALL", keyword = "NONE"){
  library(tidyr)
  library(httr)
  response <- "https://api.nasa.gov/DONKI/CMEAnalysis?" %>%
    paste(., "startDate=", start_date, "&endDate=", end_date, "&mostAccurateOnly=", tolower(mostAccurateOnly), "&completeEntryOnly=", tolower(completeEntryOnly), "&speed=", speed, "&halfAngle=", halfAngle, "&catalog=", catalog, "&keyword=", keyword, "&api_key=", key, sep = "") %>%
    GET(.)
  if (response$status_code != 200){
    message("Unsuccessful status of response!")
  }
  result <- content(response)
  return(result)
}
