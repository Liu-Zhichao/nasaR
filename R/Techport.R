#' Techport: API to make NASA technology project data available in a machine-readable format
#'
#' Techport allows the public to discover the technologies NASA is working on every day to explore space, understand the universe,
#' and improve aeronautics.
#'
#' @param key String. Your NASA API key, you can enter your key in the function parameter, but it's not recommended. Instead, you'd better save your key in R environment and call it "NASA_TOKEN". Then the function would automatically acquire your key info.
#' @param id_parameter Integer. The id value of the TechPort record.
#' @param all_valid_id Boolean. Print out all valid id of TechPort record if TRUE. FALSE as default.
#' @param update_since Date. The start date of returned TechPort record you want.
#' @return Info of technology which NASA is working on.
#' @examples
#' Techport(id_parameter = 17792)
#' Techport(all_valid_id = TRUE)
#' Techport(update_since = as.Date("2016-01-01"))
#' @export
Techport <- function(key = Sys.getenv("NASA_TOKEN"), id_parameter = NULL, all_valid_id = FALSE, update_since = NULL){
  library(tidyr)
  library(httr)
  if (all_valid_id){
    response <- "https://api.nasa.gov/techport/api/projects?" %>%
      paste(., "api_key=", key, sep = "") %>%
      GET(.)
    if (response$status_code != 200){
      message("Unsuccessful status of response!")
    }
    result <- content(response)
    return(result)
  }else{
    if (is.null(update_since) == FALSE){
      response <- "https://api.nasa.gov/techport/api/projects?" %>%
        paste(., "updatedSince=", update_since, "&api_key=", key, sep = "") %>%
        GET(.)
      if (response$status_code != 200){
        message("Unsuccessful status of response!")
      }
      result <- content(response)
      return(result)
    }
    response <- "https://api.nasa.gov/techport/api/projects/" %>%
      paste(., id_parameter, "?api_key=", key, sep = "") %>%
      GET(.)
    if (response$status_code != 200){
      message("Unsuccessful status of response!")
    }
    result <- content(response)
    return(result)
  }
}
