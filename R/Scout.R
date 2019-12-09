#' Scout: Solar System Dynamics and Center for Near-Earth Object Studies - NEOCP orbits, ephemerides, and impact risk data
#'
#' This API provides access to near-realtime results from the CNEOS Scout system.
#' See detailed info at: https://ssd-api.jpl.nasa.gov/doc/scout.html.
#'
#' This API supports two query modes:
#'
#' O - Object Detail Queries
#'
#' E - Ephemeris Queries
#'
#' @param mode String. Mode to select, "O" or "E". "O" as default.
#' @param tdes String. Mode: O, E. Select data for the NEOCP object matching this temporary designation (e.g., "P10uUSw")
#' @param plot String. Mode: O. Get plot files for the specified NEOCP object of the selected type ("el"=elements, "ca"=close-approach, "sr"=systematic-ranging). Allowable values: “el”, “ca”, “sr”, “el:ca”, “ca:el:sr” or any similar combination delimited by : where duplicates are ignored.
#' @param file String. Mode: O. Get the list of available data files (when file=list) or get the requested data file for the specified NEOCP object; currently, only “mpc” file is available. Allowable values: “list”, “mpc”.
#' @param orbits Boolean. Mode: O, E. Get sampled orbits data for the specified NEOCP object. FALSE as default.
#' @param n_orbits Number. Mode: O, E. Limit the number of sampled orbits to this value. Range: 1 - 1000. 1000 as default.
#' @param eph_start Date/String. Mode: E. Get the ephemeris for the specified NEOCP object at this time UTC. "now" as default.
#' @param eph_stop Date. Mode: E. Set the ephemeris stop-time (if specified, requires eph_start and must be later than eph_start).
#' @param eph_step String. Mode: E. Set the ephemeris step-size (if specified, requires both eph_start and eph_stop; if not specified, set to the span). Allowable values: "#d", "#h", "#m" (where # is a positive definite integer).
#' @param obs_code String. Mode: E. Get the ephemeris for the specified NEOCP object relative to the specified MPC observatory code. "500" as default.
#' @param fov_diam Number. Mode: E. Specify the size (diameter) of the field-of-view in arc-minutes. Range: (0, 1800]
#' @param fov_ra String. Mode: E. Specify the field-of-view center (R.A. component); requires fov_diam and fov_dec; invalid if eph_stop is set. Allowable values: deg "hh:mm:ss.s" "hh mm ss.s" [0:360) degrees [0:24) hours.
#' @param fov_dec String. Mode: E. Specify the field-of-view center (Dec. component): requires fov_diam and fov_ra; invalid if eph-stop is set. Allowable values: +/-deg "dd-mm-ss" "dd mm ss" (absolute value must be less than 90 degrees).
#' @param fov_vmag Number. Mode: E. Filter ephemeris results to those with V-magnitude of this value or brighter; requires fov_diam. Range: [0:40].
#' @return Data of NEOCP orbits, ephemerides, and impact risk.
#' @examples
#' ## Note that the NEOCP object tdes used in the following examples is not guaranteed to still exist in the database.
#' ##### Mode: O
#' ## Scout(tdes = "P10vY9r")
#' ## Scout(tdes = "P10vY9r", plot = "el")
#' ## Scout(tdes = "P10vY9r", orbits = 1)
#' ##### Mode: E
#' ## Scout(mode = "E", tdes = "P10vY9r", eph_start = "2016-09-24T12:00:00")
#' ## Scout(mode = "E", tdes = "P10vY9r", eph_start = "2016-09-25T18:00:00", eph_stop = "2016-09-26T06:00:00", eph_step = "2h")
#' @export
Scout <- function(mode = "O", tdes = NULL, plot = NULL, file = NULL, orbits = FALSE, n_orbits = 1000, eph_start = "now", eph_stop = NULL,
                  eph_step = NULL, obs_code = "500", fov_diam = NULL, fov_ra = NULL, fov_dec = NULL, fov_vmag = NULL){
  library(tidyr)
  library(httr)
  url <- "https://ssd-api.jpl.nasa.gov/scout.api?" %>%
    paste(., "orbits=", tolower(orbits), "&n_orbits=", n_orbits, sep = "")
  if (mode == "O"){
    if (is.null(tdes) == FALSE){
      url <- paste(url, "&tdes=", tdes, sep = "")}
    if (is.null(plot) == FALSE){
      url <- paste(url, "&plot=", plot, sep = "")}
    if (is.null(file) == FALSE){
      url <- paste(url, "&file=", file, sep = "")}
  }else if (mode == "E"){
    url <- paste(url, "&eph-start=", eph_start, "&obs-code=", obs_code, sep = "")
    if (is.null(tdes) == FALSE){
      url <- paste(url, "&tdes=", tdes, sep = "")}
    if (is.null(plot) == FALSE){
      url <- paste(url, "&plot=", plot, sep = "")}
    if (is.null(file) == FALSE){
      url <- paste(url, "&file=", file, sep = "")}
    if (is.null(eph_stop) == FALSE){
      url <- paste(url, "&eph-stop=", eph_stop, sep = "")}
    if (is.null(eph_step) == FALSE){
      url <- paste(url, "&eph-step=", eph_step, sep = "")}
    if (is.null(fov_diam) == FALSE){
      url <- paste(url, "&fov-diam=", fov_diam, sep = "")}
    if (is.null(fov_ra) == FALSE){
      url <- paste(url, "&fov-ra=", fov_ra, sep = "")}
    if (is.null(fov_dec) == FALSE){
      url <- paste(url, "&fov-dec=", fov_dec, sep = "")}
    if (is.null(fov_vmag) == FALSE){
      url <- paste(url, "&fov-vmag=", fov_vmag, sep = "")}
  }
  response <- GET(url)
  if (response$status_code != 200){
    message("Unsuccessful status of response!")
  }
  result <- content(response)
  return(result)
}
