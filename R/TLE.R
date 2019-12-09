#' TLE: Two line element data for earth-orbiting objects at a given point in time.
#'
#' The TLE API provides up to date two line element set records, the data is updated daily from
#' CelesTrak and served in JSON format. A two-line element set (TLE) is a data format encoding a
#' list of orbital elements of an Earth-orbiting object for a given point in time.
#'
#' @param satellite_name String. Performing a search by satellite name.
#' @param satellite_num Integer. Retrieving a single TLE record where query is satellite number.
#' @return Data of earth-orbiting objects.
#' @examples
#' TLE(satellite_name = "HTV")
#' TLE(satellite_num = 43553)
#' @export
TLE <- function(satellite_name = NULL, satellite_num = NULL){
  library(tidyr)
  library(httr)
  if (is.null(satellite_name) == FALSE){
    response <- "https://data.ivanstanojevic.me/api/tle?search=" %>%
      paste(., satellite_name, sep = "") %>%
      GET(.)
    result <- content(response)
    return(result)
  }else{
    response <- "https://data.ivanstanojevic.me/api/tle/" %>%
      paste(., satellite_num, sep = "") %>%
      GET(.)
    result <- content(response)
    return(result)
  }

}
