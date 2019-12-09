#' Asteroids NeoWs: Near Earth Object Web Services
#'
#' NeoWs (Near Earth Object Web Service) is a RESTful web service for near earth Asteroid information.
#' With NeoWs a user can: search for Asteroids based on their closest approach date to Earth, lookup a specific Asteroid with its NASA JPL small body id, as well as browse the overall dataset.
#' Dataset: All the data is from the NASA JPL Asteroid team (http://neo.jpl.nasa.gov/).
#'
#' Neo_Feed: Retrieve a list of Asteroids based on their closest approach date to Earth.
#'
#' Neo_Lookup: Lookup a specific Asteroid based on its NASA JPL small body (SPK-ID) ID.
#'
#' Neo_Browse: Browse the overall Asteroid dataset.
#'
#' @param key String. Your NASA API key, you can enter your key in the function parameter, but it's not recommended. Instead, you'd better save your key in R environment and call it "NASA_TOKEN". Then the function would automatically acquire your key info.
#' @param start_date Date. Starting date for asteroid search.
#' @param end_date Date. Ending date for asteroid search. 7 days after start_date as default.
#' @param as_dataframe Boolean. Return the data in the form of dataframe instead of nested list. False as default.
#' @param asteroid_id Long integer. Asteroid SPK-ID correlates to the NASA JPL small body.
#' @return Data of Near Earth Object.
#' @examples
#' Neo_Feed(start_date = as.Date("2019-11-01"), end_date = as.Date("2019-11-03"), as_dataframe = TRUE)
#' Neo_Lookup(asteroid_id = 3542519)
#' Neo_Browse()
#' @export
Neo_Lookup <- function(key = Sys.getenv("NASA_TOKEN"), asteroid_id){
  library(tidyr)
  library(httr)
  response <- "https://api.nasa.gov/neo/rest/v1/neo/" %>%
    paste(., asteroid_id, "?api_key=", key, sep = "") %>%
    GET(.)
  if (response$status_code != 200){
    message("Unsuccessful status of response!")
  }
  result <- content(response)
  return(result)
}
