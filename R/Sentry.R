#' Sentry: Solar System Dynamics and Center for Near-Earth Object Studies - NEO Earth impact risk assessment data
#'
#' This API provides access to results from the CNEOS Sentry system.
#' See detailed info at: https://ssd-api.jpl.nasa.gov/doc/sentry.html.
#'
#' This API supports four query modes:
#'
#' O - obtain details related to a specified Sentry object
#'
#' S - obtain summary data for all available Sentry objects
#'
#' V - obtain data for all available VIs (Virtual Impactors)
#'
#' R - obtain summary data for objects removed from Sentry
#'
#' @param mode String. Mode to select, "O" or "S" or "V" or "R". "S" as default.
#' @param spk Integer. Mode: O. Select data for the object matching this SPK-ID (e.g., 2029075).
#' @param des String. Mode: O. Select data for the object matching this designation (e.g., "29075" or "2000 SG344").
#' @param h_max Number. Mode: S, V. Limit data to those with an absolute magnitude, H (weighted-mean for mode-S) less than or equal to this value. Allowable values: [-10:100].
#' @param ps_min Integer. Mode: S, V. Limit data to those with a (weighted-mean for mode-S) Palermo scale (PS) greater than or equal to this value. Allowable values: [-20:20].
#' @param ip_min Number. Mode: S, V. Limit data to those with a (weighted-mean for mode-S) impact-probability (IP) greater than or equal to this value. Allowable values: [1 - 1e-10].
#' @param days Integer. Mode: S, V. Number of days since last observation: limit data to those objects that have been observed within the specified number of days (if the number is negative, limit data to those which have not been observed with the specified number of days). Allowable values: ABS(days) > 6.
#' @param all Boolean. Mode: V. Request the complete VI data set. FALSE as default.
#' @param removed Boolean. Mode: R. Request the list of removed objects. FALSE as default.
#' @return Data of NEO Earth impact risk assessment.
#' @examples
#' ##### Mode: O
#' Sentry(mode = "O", des = "99942")
#' Sentry(mode = "O", des = "2000%20SG344")
#' ##### Mode: S
#' Sentry()
#' ##### Mode: V
#' Sentry(mode = "V", all = TRUE, ip_min = 1e-3)
#' ##### Mode: R
#' Sentry(mode = "R", removed = TRUE)
#' @export
Sentry <- function(mode = "S", spk = NULL, des = NULL, h_max = NULL, ps_min = NULL, ip_min = NULL, days = NULL, all = FALSE, removed = FALSE){
  library(tidyr)
  library(httr)
  if (mode == "S"){
    url <- "https://ssd-api.jpl.nasa.gov/sentry.api?"
    i <- 1
    if (is.null(h_max) == FALSE){
      if (i == 1){
        url <- paste(url, "h-max=", h_max, sep = "")
        i <- i + 1
      }else{
        url <- paste(url, "&h-max=", h_max, sep = "")
      }
    }
    if (is.null(ps_min) == FALSE){
      if (i == 1){
        url <- paste(url, "ps-min=", ps_min, sep = "")
        i <- i + 1
      }else{
        url <- paste(url, "&ps-min=", ps_min, sep = "")
      }
    }
    if (is.null(ip_min) == FALSE){
      if (i == 1){
        url <- paste(url, "ip-min=", ip_min, sep = "")
      }else{
        url <- paste(url, "&ip-min=", ip_min, sep = "")
      }
    }
    if (is.null(days) == FALSE){
      if (i == 1){
        url <- paste(url, "days=", days, sep = "")
        i <- i + 1
      }else{
        url <- paste(url, "&days=", days, sep = "")
      }
    }
  }else if (mode == "O"){
    j <- 1
    url <- "https://ssd-api.jpl.nasa.gov/sentry.api?"
    if (is.null(spk) == FALSE){
      if (j == 1){
        url <- paste(url, "spk=", spk, sep = "")
        j <- j + 1
      }else{
        url <- paste(url, "&spk=", spk, sep = "")
      }
    }
    if (is.null(des) == FALSE){
      if (j == 1){
        url <- paste(url, "des=", des, sep = "")
        j <- j + 1
      }else{
        url <- paste(url, "&des=", des, sep = "")
      }
    }
  }else if (mode == "V"){
    url <- "https://ssd-api.jpl.nasa.gov/sentry.api?" %>%
      paste(., "all=", all, sep = "")
    if (is.null(h_max) == FALSE){
      url <- paste(url, "&h-max=", h_max, sep = "")}
    if (is.null(ps_min) == FALSE){
      url <- paste(url, "&ps-min=", ps_min, sep = "")}
    if (is.null(ip_min) == FALSE){
      url <- paste(url, "&ip-min=", ip_min, sep = "")}
    if (is.null(days) == FALSE){
      url <- paste(url, "&days=", days, sep = "")}
  }else if (mode == "R"){
    url <- "https://ssd-api.jpl.nasa.gov/sentry.api?" %>%
      paste(., "removed=", removed, sep = "")
  }
  response <- GET(url)
  if (response$status_code != 200){
    message("Unsuccessful status of response!")
  }
  result <- content(response)
  return(result)
}
