#' Print astronomy picture of the day
#'
#' The function helps print out an stronomy picture of the day.
#' Each day a different image or photograph of our fascinating universe is featured, along with a brief explanation written by a professional astronomer.
#'
#'
#' @param key String. Your NASA API key, you can enter your key directly in the function parameter, but it's not recommended. Instead, you'd better save your key in R environment and call it "NASA_TOKEN". Then the function would automatically acquire your key info.
#' @param date Date. The date("YYYY-MM-DD") of the APOD image to retrieve. Today as default.
#' @param hd Boolean. Retrieve the URL for the high resolution image. Not allowable if it is a video. False as default.
#' @param return_text Boolean. Return the explanation of the image. False as default.
#' @param download_filename String. Filename of downloaded image. Not allowable if it is a video. "img.jpg" as default.
#' @return An astronomy picture(hd or not) of the day (can be downloaded) or a video (return the video website).
#' @examples
#' APOD()
#' APOD(date = as.Date("2019-11-01"), hd = TRUE, return_text = TRUE)
#' @export
APOD <- function(key = Sys.getenv("NASA_TOKEN"), date = Sys.Date(), hd = FALSE, return_text = FALSE, download_filename = "img.jpg"){
  library(tidyr)
  library(httr)
  library(jpeg)
  library(stringr)
  url <- "https://api.nasa.gov/planetary/apod?" %>%
    paste(., "api_key=", key, "&date=", date, sep = "")
  response <- GET(url)
  if (response$status_code != 200){
    message("Unsuccessful status of response!")
  }
  response <- content(response)
  if (str_detect(response$url, "jpg")){
    hd_or_not <- ifelse(hd, response$hdurl, response$url)
    download.file(hd_or_not, download_filename, mode = 'wb')
    jpg <- readJPEG(download_filename, native = TRUE)
    plot(0:1, 0:1, type = "n", ann = FALSE, axes = FALSE)
    rasterImage(jpg, 0, 0, 1, 1)
  }else{
    cat("Here is the video website:", response$url, "\n")
  }
  if (return_text == TRUE){
    return(response$explanation)
  }
}
