#' EPIC: Earth Polychromatic Imaging Camera
#'
#' The EPIC API provides information on the daily imagery collected by DSCOVR's Earth Polychromatic Imaging Camera (EPIC) instrument.
#' Uniquely positioned at the Earth-Sun Lagrange point, EPIC provides full disc imagery of the Earth and captures unique perspectives of certain astronomical events such as
#' lunar transits using a 2048x2048 pixel CCD (Charge Coupled Device) detector coupled to a 30-cm aperture Cassegrain telescope.
#' Image metadata and key information are provided by the JSON API and can be requested by date and for the most recent available date.
#' A listing of all available dates can also be retrieved via the API for more granular control.
#'
#' @param key String. Your NASA API key, you can enter your key in the function parameter, but it's not recommended. Instead, you'd better save your key in R environment and call it "NASA_TOKEN". Then the function would automatically acquire your key info.
#' @param query_by_date String. There are several options of this parameter:
#'
#' 1. "natural": Metadata on the most recent date of natural color imagery. Most recent natural color as default.
#'
#' 2. "natural/date": Metadata for natural color imagery available for a given date. Today as default.
#'
#' 3. "natural/all": A listing of all dates with available natural color imagery.
#'
#' 4. "natural/available": Alternate listing of all dates with available natural color imagery.
#'
#' 5. "enhanced": Metadata on the most recent date of enhanced color imagery. Most recent enhanced Color as default.
#'
#' 6. "enhanced/date": Metadata for enhanced color imagery for a given date. Today as default.
#'
#' 7. "enhanced/all" A listing of all dates with available enhanced color imagery.
#'
#' 8. "enhanced/available": Alternate listing of all dates with available enhanced color imagery.
#' @param date Date. This parameter only available when you select "natural/date" or "enhanced/date" in query_by_date. Today as default.
#' @param download Boolean. Download the most recent image, only available when set query_by_date as option 1, 2, 5, 6 mentioned above. FALSE as default.
#' @return Metadata:
#'
#' Image[name]
#'
#' Date
#'
#' Caption
#'
#' centroid_coordinates
#'
#' dscovr_j2000_position
#'
#' lunar_j2000_position
#'
#' sun_j2000_position
#'
#' attitude_quaternions
#' @examples
#' EPIC(query_by_date = "natural")
#' EPIC(query_by_date = "enhanced/date", date = as.Date("2019-11-01"))
#' EPIC(query_by_date = "natural/date", date = as.Date("2019-06-01"), download = TRUE)
#' @export
EPIC <- function(key = Sys.getenv("NASA_TOKEN"), query_by_date, date = Sys.Date(), download = FALSE){
  library(tidyr)
  library(httr)
  library(stringr)
  library(png)
  url <- "https://api.nasa.gov/EPIC/api/" %>%
    paste(., query_by_date, sep = "")
  if (query_by_date == "natural/date" | query_by_date == "enhanced/date"){
    url <- paste(url, date, "?api_key=", key, sep = "")
  }else{
    url <- paste(url, "?api_key=", key, sep = "")
  }
  response <- GET(url)
  if (response$status_code != 200){
    message("Unsuccessful status of response!")
  }
  result <- content(response)
  if (str_detect(query_by_date, pattern = "all|available")){
    result <- unlist(result)
  }
  if (download){
    download_date <- gsub("-", "/", str_sub(result[[1]]$date, start = 1, end = 10))
    natural_or_enhanced <- ifelse(str_detect(query_by_date, "natural"), "natural", "enhanced")
    download_url <- paste("https://api.nasa.gov/EPIC/archive/", natural_or_enhanced, "/", download_date, "/png/", result[[1]]$image, ".png?api_key=", key, sep = "")
    download.file(download_url, "img.png", mode = 'wb')
    img <- readPNG("img.png", native = TRUE)
    plot(0:1, 0:1, type = "n", ann = FALSE, axes = FALSE)
    rasterImage(img, 0, 0, 1, 1)
  }
  return(result)
}

