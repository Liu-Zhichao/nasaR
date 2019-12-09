#' CAD: Solar System Dynamics and Center for Near-Earth Object Studies - Asteroid and comet close approaches to the planets in the past and future
#'
#' This API provides access to current close-approach data for all
#' asteroids and comets in JPL’s SBDB (Small-Body DataBase). See detailed info at: https://ssd-api.jpl.nasa.gov/doc/cad.html.
#'
#' @param date_min Date. Exclude data earlier than this date "YYYY-MM-DD" or date/time "YYYY-MM-DDThh:mm:ss" or "now" for the current date. "now" as default.
#' @param date_max Date. Exclude data later than this date "YYYY-MM-DD" or date/time "YYYY-MM-DDThh:mm:ss". "now" + 60 as default.
#' @param energy_min String. Exclude data with an approach distance less than this, e.g., "0.05", "10LD".
#' @param dist_max String. Exclude data with an approach distance greater than this (see dist-min). "0.05" as default.
#' @param h_min Number. Exclude data from objects with H-values less than this (e.g., 22 meaning objects smaller than this).
#' @param h_max Number. Exclude data from objects with H-value greater than this (e.g., 17.75 meaning objects larger than this).
#' @param v_inf_min Number. Exclude data with V-infinity less than this positive value in km/s (e.g., 18.5).
#' @param v_inf_max Number. Exclude data with V-infinity greater than this positive value in km/s (e.g., 20).
#' @param v_rel_min Number. Exclude data with V-relative less than this positive value in km/s (e.g., 11.2).
#' @param v_rel_max Number. Exclude data with V-relative greater than this positive value in km/s (e.g., 19).
#' @param class String. Limit data to objects with the specified orbit-class (e.g., "ATE").
#' @param pha Boolean. Limit data to PHAs. FALSE as default.
#' @param nea Boolean. Limit data to NEAs. FALSE as default.
#' @param comet Boolean. Limit data to comets. FALSE as default.
#' @param nea-comet Boolean. Limit data to NEAs and comets. FALSE as default.
#' @param neo Boolean. Limit data to NEOs. TRUE as default.
#' @param kind String. Limit data to objects of the specified kind ("a"=asteriod, "an"=numbered-asteroids, "au"=unnumbered-asteroids, "c"=comets, "cn"=numbered-comets, "cu"=unnumbered-comets, "n"=numbered-objects, and "u"=unnumbered-objects).
#' @param spk Integer. Only data for the object matching this SPK-ID (e.g., 2000433).
#' @param des String. only data for the object matching this designation (e.g., "2015 AB" or "141P" or "433").
#' @param body String. Limit data to close-approaches to the specified body (e.g., "Earth") or allow all bodies with "ALL" or *. "Earth" as default.
#' @param sort String. Sort data on the specified field: “date”, “dist”, “dist-min”, “v-inf”, “v-rel”, “h”, or “object” (default sort order is ascending: prepend “-“ for descending). "date" as default.
#' @param limit Integer. Limit data to the first N results (where N is the specified number and must be an integer value greater than zero).
#' @param fullname Boolean. Include the full-format object name/designation. FALSE as default.
#' @return Data of asteroids and comets in JPL’s SBDB (Small-Body DataBase).
#' @examples
#' CAD(des = "433", date_min = as.Date("2019-01-01"), date_max = as.Date("2100-01-01"), dist_max = "0.2")
#' CAD(dist_max = "10LD", date_min = as.Date("2018-01-01"), sort = "dist")
#' @export
CAD <- function(date_min = "now", date_max = lubridate::today() + 60, dist_min = NULL,
                dist_max = "0.05", h_min = NULL, h_max = NULL, v_inf_min = NULL, v_inf_max = NULL,
                v_rel_min = NULL, v_rel_max = NULL, class = NULL, pha = FALSE, nea = FALSE, comet = FALSE,
                nea_comet = FALSE, neo = TRUE, kind = NULL, spk = NULL, des = NULL, body = "Earth",
                sort = "date", limit = NULL, fullname = FALSE){
  library(tidyr)
  library(httr)
  url <- "https://ssd-api.jpl.nasa.gov/cad.api?" %>%
    paste(., "date-min=", date_min, "&date-max=", date_max, "&dist-max=", dist_max, "&pha=", tolower(pha), "&nea=", tolower(nea), "&comet=", tolower(comet), "&nea-comet=", tolower(nea_comet), "&neo=", tolower(neo), "&body=", body, "&sort=", sort, "&fullname=", tolower(fullname), sep = "")
  if (is.null(dist_min) == FALSE){
    url <- paste(url, "&dist-min=", dist_min, sep = "")}
  if (is.null(h_min) == FALSE){
    url <- paste(url, "&h-min=", h_min, sep = "")}
  if (is.null(h_max) == FALSE){
    url <- paste(url, "&h-max=", h_max, sep = "")}
  if (is.null(v_inf_min) == FALSE){
    url <- paste(url, "&v-inf-min=", v_inf_min, sep = "")}
  if (is.null(v_inf_max) == FALSE){
    url <- paste(url, "&v-inf-max=", v_inf_max, sep = "")}
  if (is.null(v_rel_min) == FALSE){
    url <- paste(url, "&v-rel-min=", v_rel_min, sep = "")}
  if (is.null(v_rel_max) == FALSE){
    url <- paste(url, "&v-rel-max=", v_rel_max, sep = "")}
  if (is.null(class) == FALSE){
    url <- paste(url, "&class=", class, sep = "")}
  if (is.null(kind) == FALSE){
    url <- paste(url, "&kind=", kind, sep = "")}
  if (is.null(spk) == FALSE){
    url <- paste(url, "&spk=", spk, sep = "")}
  if (is.null(des) == FALSE){
    url <- paste(url, "&des=", des, sep = "")}
  if (is.null(limit) == FALSE){
    url <- paste(url, "&limit=", limit, sep = "")}
  response <- GET(url)
  if (response$status_code != 200){
    message("Unsuccessful status of response!")
  }
  result <- content(response)
  return(result)
}

