#' Fireball: Solar System Dynamics and Center for Near-Earth Object Studies - Fireball atmospheric impact data reported by US Government sensors
#'
#' The fireball data API provides a method of requesting specific records from the available data-set. Every successful query will return content representing one or more fireball data records.
#' See detailed info at: https://ssd-api.jpl.nasa.gov/doc/fireball.html.
#'
#' @param date_min Date. Exclude data earlier than this date "YYYY-MM-DD" or date/time "YYYY-MM-DDThh:mm:ss". Today as default.
#' @param date_max Date. Exclude data later than this date "YYYY-MM-DD" or date/time "YYYY-MM-DDThh:mm:ss". "now" + 60 as default.
#' @param energy_min String. Exclude data with total-radiated-energy less than this positive value in joules ×10^10 (e.g., "0.3" = 0.3×1010 joules).
#' @param energy_max String. Exclude data with total-radiated-energy greater than this (see energy-min).
#' @param impact_e_min String. Exclude data with estimated impact energy less than this positive value in kilotons (kt) (e.g., "0.08" kt).
#' @param impact_e_max String. Exclude data with total-radiated-energy greater than this (see impact-e-min).
#' @param vel_min Number. Exclude data with velocity-at-peak-brightness less than this positive value in km/s (e.g., 18.5).
#' @param vel_max Number. Exclude data with velocity-at-peak-brightness greater than this positive value in km/s (e.g., 20).
#' @param alt_min Number. Exclude data from objects with an altitude less than this (e.g., 22 meaning objects smaller than this).
#' @param alt_max Number. Exclude data from objects with an altitude greater than this (e.g., 17.75 meaning objects larger than this).
#' @param req_loc Boolean. Location (latitude and longitude) required; when set TRUE, exclude data without a location. FALSE as default.
#' @param req_alt Boolean. Altitude required; when set true, exclude data without an altitude. FALSE as default.
#' @param req_vel Boolean. Velocity required; when set true, exclude data without a velocity. FALSE as default.
#' @param req_vel_comp Boolean. Velocity components required; when set TRUE, exclude data without velocity components. FALSE as default.
#' @param vel_comp Boolean. Include velocity components. FALSE as default.
#' @param sort String. Sort data on the specified field: “date”, “dist”, “dist-min”, “v-inf”, “v-rel”, “h”, or “object” (default sort order is ascending: prepend “-“ for descending). "date" as default.
#' @param limit Integer. Limit data to the first N results (where N is the specified number and must be an integer value greater than zero).
#' @return Fireball atmospheric impact data.
#' @examples
#' Fireball(date_min = as.Date("2014-01-01"), limit = 20)
#' Fireball(date_min = as.Date("2015-01-01"), req_alt = TRUE, sort = "-date")
#' @export
Fireball <- function(date_min = lubridate::today(), date_max = lubridate::today() + 60, energy_min = NULL,
                energy_max = NULL, impact_e_min = NULL, impact_e_max = NULL, vel_min = NULL, vel_max = NULL,
                alt_min = NULL, alt_max = NULL, req_loc = FALSE, req_alt = FALSE,
                req_vel = FALSE, req_vel_comp = FALSE, vel_comp = FALSE, sort = "date", limit = NULL){
  library(tidyr)
  library(httr)
  url <- "https://ssd-api.jpl.nasa.gov/fireball.api?" %>%
    paste(., "date-min=", date_min, "&date-max=", date_max, "&req-loc=", tolower(req_loc), "&req-alt=", tolower(req_alt), "&req-vel=", tolower(req_vel), "&req-vel-comp=", tolower(req_vel_comp), "&vel-comp=", tolower(vel_comp), "&sort=", sort, sep = "")
  if (is.null(energy_min) == FALSE){
    url <- paste(url, "&energy-min=", energy_min, sep = "")}
  if (is.null(energy_max) == FALSE){
    url <- paste(url, "&energy-max=", energy_max, sep = "")}
  if (is.null(impact_e_min) == FALSE){
    url <- paste(url, "&impact-e-min=", impact_e_min, sep = "")}
  if (is.null(impact_e_max) == FALSE){
    url <- paste(url, "&impact-e-max=", impact_e_max, sep = "")}
  if (is.null(vel_min) == FALSE){
    url <- paste(url, "&vel-min=", vel_min, sep = "")}
  if (is.null(vel_max) == FALSE){
    url <- paste(url, "&vel-max=", vel_max, sep = "")}
  if (is.null(alt_min) == FALSE){
    url <- paste(url, "&alt-min=", alt_min, sep = "")}
  if (is.null(alt_max) == FALSE){
    url <- paste(url, "&alt-max=", alt_max, sep = "")}
  if (is.null(limit) == FALSE){
    url <- paste(url, "&limit=", limit, sep = "")}
  response <- GET(url)
  if (response$status_code != 200){
    message("Unsuccessful status of response!")
  }
  result <- content(response)
  return(result)
}


