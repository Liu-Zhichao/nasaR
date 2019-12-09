#' NHATS: Solar System Dynamics and Center for Near-Earth Object Studies - Human-accessible NEOs data
#'
#' The NHATS API provides a method of requesting data from the NHATS-related tables in the SBDB. These data will primarily support the CNEOS “Accessible NEAs” web-page.
#' See detailed info at: https://ssd-api.jpl.nasa.gov/doc/nhats.html.
#'
#' This API supports two query modes:
#'
#' S - obtain summary data spanning all available NHATS object
#'
#' O - obtain details related to a specified NHATS object
#'
#' @param mode String. Mode to select, "S" or "O". "S" as default.
#' @param dv Integer. Mode: S, O. Minimum total delta-V (km/s). Allowable values: 4,5,6,7,8,9,10,11,12. 12 as default.
#' @param dur Integer. Mode: S, O. Minimum total duration (days). Allowable values: 60,90,120,150,180,210,240,270,300,330,360,390,420,450. 450 as default.
#' @param stay Integer. Mode: S, O. Minimum stay (days). Allowable values: 8,16,24,32. 8 as default.
#' @param launch String. Mode: S, O. Launch window (year range). Allowable values: "2020-2025", "2025-2030", "2030-2035", "2035-2040", "2040-2045", "2020-2045". "2020-2045" as default.
#' @param h Integer. Mode: S. Object’s maximum absolute magnitude, H (mag). Allowable values: 16,17,18,19,20,21,22,23,24,25,26,27,28,29,30.
#' @param occ Integer. Mode: S. Object’s maximum orbit codition code (OCC). Allowable values: 0,1,2,3,4,5,6,7,8.
#' @param spk Integer. Mode: O. Select data for the object matching this SPK-ID (e.g., 2000433).
#' @param des String. Mode: O. Select data for the object matching this designation (e.g., "2015 AB" or "141P" or "433").
#' @param plot Boolean. Mode: O. Include base-64 encoded plot image file content via output field plot_base64. FALSE as default.
#' @return Data of NHATS objects.
#' @examples
#' ##### Mode: S
#' NHATS(dv = 6, dur = 360, stay = 8, launch = "2020-2045", h = 26, occ = 7)
#' ##### Mode: O
#' NHATS(mode = "O", des = "99942")
#' NHATS(mode = "O", des = "2000%20SG344", dv = 6, dur = 360, stay = 8, launch = "2020-2045")
#' @export
NHATS <- function(mode = "S", dv = 12, dur = 450, stay = 8, launch = "2020-2045", h = NULL, occ = NULL, spk = NULL, des = NULL, plot = FALSE){
  library(tidyr)
  library(httr)
  url <- "https://ssd-api.jpl.nasa.gov/nhats.api?" %>%
    paste(., "dv=", dv, "&dur=", dur, "&stay=", stay, "&launch=", launch, sep = "")
  if (mode == "S"){
    if (is.null(h) == FALSE){
      url <- paste(url, "&h=", h, sep = "")}
    if (is.null(occ) == FALSE){
      url <- paste(url, "&occ=", occ, sep = "")}
  }else if (mode == "O"){
    url <- paste(url, "&plot=", tolower(plot), sep = "")
    if (is.null(spk) == FALSE){
      url <- paste(url, "&spk=", spk, sep = "")}
    if (is.null(des) == FALSE){
      url <- paste(url, "&des=", des, sep = "")}
  }
  response <- GET(url)
  if (response$status_code != 200){
    message("Unsuccessful status of response!")
  }
  result <- content(response)
  return(result)
}
