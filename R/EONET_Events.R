#' EONET_Events: The Earth Observatory Natural Event Tracker
#'
#' Get access to the information of events on the Earth (filtered by events/categories/layers).
#'
#' If you want to filter the data by events, then you need set these parameters: source, status, limit, days, by_events=TRUE(default).
#'
#' If you want to filter the data by categories, then you need set these parameters: category_id, source, status, limit, days, by_events=FALSE.
#'
#' If you want to filter the data by layers, then you need to set the parameter: by_layers = TRUE, category_id
#'
#' @param source Vector. Event sources in the EONET system. c("InciWeb", "EO") as default. See detailed info: https://eonet.sci.gsfc.nasa.gov/api/v2.1/sources
#' @param status String. Events that have ended are assigned a closed date and the existence of that date will allow you to filter for only-open or only-closed events. "open" as default.
#' @param limit Integer. Limits the number of events returned. 5 as default.
#' @param days Integer. Limits the number of prior days (including today) from which events will be returned. 20 as default.
#' @param by_events Boolean. Filters the data by events(TRUE) or by categories(FALSE). TRUE as default.
#' @param by_layers Boolean. Filters the data by layers. FALSE as default.
#' @param category_id Integer. Filters the events by the category. 8 as default. See detailed info: https://eonet.sci.gsfc.nasa.gov/api/v2.1/categories
#' @return List of info about natural events on the Earth.
#' @examples
#' #### Filtered by events:
#' EONET_Events(source = "InciWeb", limit = 10, days = 30)
#' #### Filtered by categories:
#' EONET_Events(category_id = 8, source = "EO", limit = 5, days = 365, by_events = FALSE)
#' #### Filtered by layers:
#' EONET_Events(by_layers = TRUE, category_id = 14)
#' @export
EONET_Events <- function(source = c("InciWeb", "EO"), status = "open", limit = 5, days = 20, by_events = TRUE, by_layers = FALSE, category_id = 8){
  library(tidyr)
  library(httr)
  if (by_layers){
    response <- "https://eonet.sci.gsfc.nasa.gov/api/v2.1/layers/" %>%
      paste(., category_id, sep = "") %>%
      jsonlite::read_json(.)
    return(response)
  }
  else if (by_events){
    url <- "https://eonet.sci.gsfc.nasa.gov/api/v2.1/events?"
  }else{
    url <- "https://eonet.sci.gsfc.nasa.gov/api/v2.1/categories/" %>%
      paste(., category_id, "?", sep = "")
  }
  response <- url %>%
    paste(., "source=", paste(source, collapse = ","), "&status=", status, "&limit=", limit, "&days=", days, sep = "") %>%
    GET(.)
  if (response$status_code != 200){
    message("Unsuccessful status of response!")
  }
  result <- content(response)
  return(result)
}
