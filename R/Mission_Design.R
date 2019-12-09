#' Mission_Design: Solar System Dynamics and Center for Near-Earth Object Studies - Small-body mission design suite
#'
#' This API provides access to the JPL/SSD small-body mission design suite. See detailed info at: https://ssd-api.jpl.nasa.gov/doc/mdesign.html.
#'
#' Mode Q (query) - this is the standard mode, which retrieves the pre-computed mission options and low-thrust delta-V estimates stored in the small-body database.
#'
#' Mode M (map) - additional information is returned when operating the API in map mode. Apart from the information provided in query mode, the API will generate the complete dataset in order to plot time of flight vs departure date maps displaying different parameters. Mode M is an extension of mode Q.
#'
#' @param mode String. Mode to select, "Q" or "M". "Q" as default.
#' @param des String. Mode: Q, M. Designation (provisional or IAU-number) of the desired object (e.g., "2015 AB" or "141P" or "433"). Do not use des if spk or sstr are specified.
#' @param spk Integer. Mode: Q, M. SPK-ID of the desired object (e.g., 2000433). Do not use spk if des or sstr are specified.
#' @param sstr String. Mode: Q, M. Object search string: designation in various forms (including MPC packed form), case-insensitive name, or SPK-ID; designation can be an alternate provisional designation; examples: "atira", "2003 CP20", "2003cp20", "K03C20P", "163693", "2163693". Do not use sstr if des or spk are specified.
#' @param class Boolean. Mode: Q, M. If set to TRUE, return the orbit class in human-readable format instead of the three-letter code. FALSE as default.
#' @param mjd0 Integer. Mode: M. First launch date to be explored (Modified Julian Date). Range: 33282 - 73459.
#' @param span Integer. Mode: M. Duration of the launch-date period to be explored (days). Range: 10 - 9200.
#' @param tof_min Integer. Mode: M. Minimum time of flight to be considered (days). Range: 10 - 9200.
#' @param tof_max Integer. Mode: M. Maximum time of flight to be considered (days). Range: 10 - 9200.
#' @param step Integer. Mode: M. Time step used to advance both the launch date and the time of flight (days). The size of the transfer map is limited to 1,500,000 points. Consequently, if the requested configuration leads to too many points, the API will return with code 200 and an error message in the JSON payload. Range: 1,2,5,10,15,20,30.
#' @return Data of small-body mission design suite.
#' @examples
#' ##### Mode: Q
#' Mission_Design(des = "2012%20TC4")
#' Mission_Design(des = 1, class = TRUE)
#' Mission_Design(sstr = "apophis")
#' ##### Mode: M
#' Mission_Design(mode = "M", des = "2012%20TC4", mjd0 = 58490, span = 3652, tof_min = 10, tof_max = 365, step = 2)
#' @export
Mission_Design <- function(mode = "Q", des = NULL, spk = NULL, sstr = NULL, class = FALSE, mjd0 = NULL, span = NULL, tof_min = NULL, tof_max = NULL, step = NULL){
  library(tidyr)
  library(httr)
  url <- "https://ssd-api.jpl.nasa.gov/mdesign.api?" %>%
    paste(., "class=", tolower(class), sep = "")
  if (mode == "Q"){
    if (is.null(des) == FALSE){
      url <- paste(url, "&des=", des, sep = "")}
    if (is.null(spk) == FALSE){
      url <- paste(url, "&spk=", spk, sep = "")}
    if (is.null(sstr) == FALSE){
      url <- paste(url, "&sstr=", sstr, sep = "")}
  }else if (mode == "M"){
    if (is.null(des) == FALSE){
      url <- paste(url, "&des=", des, sep = "")}
    if (is.null(spk) == FALSE){
      url <- paste(url, "&spk=", spk, sep = "")}
    if (is.null(sstr) == FALSE){
      url <- paste(url, "&sstr=", sstr, sep = "")}
    if (is.null(mjd0) == FALSE){
      url <- paste(url, "&mjd0=", mjd0, sep = "")}
    if (is.null(span) == FALSE){
      url <- paste(url, "&span=", span, sep = "")}
    if (is.null(tof_min) == FALSE){
      url <- paste(url, "&tof-min=", tof_min, sep = "")}
    if (is.null(tof_max) == FALSE){
      url <- paste(url, "&tof-max=", tof_max, sep = "")}
    if (is.null(step) == FALSE){
      url <- paste(url, "&step=", step, sep = "")}
  }
  response <- GET(url)
  if (response$status_code != 200){
    message("Unsuccessful status of response! Maybe you need check if there's parameter conflits.")
  }
  result <- content(response)
  return(result)
}
