#' Insight: Mars Weather Service API
#'
#' NASA’s InSight Mars lander takes continuous weather measurements (temperature, wind, pressure) on the
#' surface of Mars at Elysium Planitia, a flat, smooth plain near Mars’ equator. Summaries of these data
#' are available at https://mars.nasa.gov/insight/weather/. This API provides per-Sol summary data for each of
#' the last seven available Sols (Martian Days). As more data from a particular Sol are downlinked from the
#' spacecraft (sometimes several days later), these values are recalculated, and consequently may
#' change as more data are received on Earth.
#'
#' @param key String. Your NASA API key, you can enter your key in the function parameter, but it's not recommended. Instead, you'd better save your key in R environment and call it "NASA_TOKEN". Then the function would automatically acquire your key info.
#' @param ver String. The version of this API. "1.0" as default.
#' @param feedtype String. The format of what is returned. Currently the default is "json" and only "json" works.
#' @param simplified_data_frame Boolean. Returns a data frame that only includes date, highest and lowest temperatrue(°F). FALSE as default. One beautiful example that could use this data frame: https://api.nasa.gov/assets/img/general/insight_photo.png.
#' @return List or dataframe of info about weather on Mars.
#' @examples
#' Insight()
#' Insight(simplified_data_frame = TRUE)
#' @export
Insight <- function(key = Sys.getenv("NASA_TOKEN"), ver = "1.0", feedtype = "json", simplified_data_frame = FALSE){
  library(tidyr)
  library(httr)
  library(purrr)
  response <- "https://api.nasa.gov/insight_weather/?" %>%
    paste(., "api_key=", key, "&ver=", ver, "&feedtype=", feedtype, sep = "") %>%
    GET(.)
  if (response$status_code != 200){
    message("Unsuccessful status of response!")
  }
  result <- content(response) %>%
    map(., ~unlist(.)) %>%
    .[1:7]
  if (simplified_data_frame){
    First_UTC <- map_chr(result, ~.[5])
    Last_UTC <- map_chr(result, ~.[10])
    High <- map_chr(result, ~.[4])
    Low <- map_chr(result, ~.[3])
    result <- data.frame(cbind(First_UTC, Last_UTC, High, Low), row.names = paste("Sol", names(First_UTC)))
  }
  return(result)
}
