#' Earth_Imagery: The Landsat 8 image on the Earth for the supplied location and date
#'
#' This function retrieves the Landsat 8 image for the supplied location and date.
#' The response will include the date and URL to the image that is closest to the supplied date.
#' The requested resource may not be available for the exact date in the request.
#'
#' @param key String. Your NASA API key, you can enter your key in the function parameter, but it's not recommended. Instead, you'd better save your key in R environment and call it "NASA_TOKEN". Then the function would automatically acquire your key info.
#' @param lat Float. Latitude of the location.
#' @param lon Float. Longitude of the location.
#' @param dim Float. Width and height of image in degrees. 0.025 as default.
#' @param date Date. Date of image; if not supplied, then the most recent image (i.e., closest to today) is returned. Today as default.
#' @param cloud_score Boolean. Calculate the percentage of the image covered by clouds. FALSE as default. If False is supplied, then no keypair is returned. If True is supplied, then a keypair will always be returned, even if the backend algorithm is not able to calculate a score. Note that this is a rough calculation, mainly used to filter out exceedingly cloudy images.
#' @param download_filename String. Filename of downloaded image. "img.png" as default.
#' @return A Landsat 8 imagery and its date.
#' @examples
#' Earth_Imagery(lon = 100.75, lat = 1.5, date = as.Date("2014-02-01"), cloud_score = TRUE)
#' @export
Earth_Imagery <- function(key = Sys.getenv("NASA_TOKEN"), lat, lon, dim = 0.025, date = Sys.Date(), cloud_score = FALSE, download_filename = "img.png"){
  library(tidyr)
  library(httr)
  library(png)
  cloud_score <- ifelse(cloud_score, "True", "False")
  response <- "https://api.nasa.gov/planetary/earth/imagery/?" %>%
    paste(., "lon=", lon, "&lat=", lat, "&dim=", dim, "&date=", date, "&cloud_score=", cloud_score, "&api_key=", key, sep = "") %>%
    GET(.)
  if (response$status_code != 200){
    message("Unsuccessful status of response!")
  }
  response <- content(response)
  download.file(response$url, download_filename, mode = 'wb')
  img <- readPNG(download_filename, native = TRUE)
  plot(0:1, 0:1, type = "n", ann = FALSE, axes = FALSE)
  rasterImage(img, 0, 0, 1, 1)
  return(paste("Time of the image: ", response$date, sep = ""))
}
