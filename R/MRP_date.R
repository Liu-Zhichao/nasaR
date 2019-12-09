#' MRP_date: Mars Rover Photos - Querying by Earth date
#'
#' Each rover has its own set of photos stored in the database, which can be queried separately.
#' There are several possible queries that can be made against the API. Photos are organized by the sol
#' (Martian rotation or day) on which they were taken, counting up from the rover's landing date.
#' A photo taken on Curiosity's 1000th Martian sol exploring Mars, for example, will have a sol attribute of 1000.
#' If instead you prefer to search by the Earth date on which a photo was taken, you can do that too.
#' Along with querying by date, results can also be filtered by the camera with which it was taken and
#' responses will be limited to 25 photos per call. Queries that should return more than 25 photos will be
#' split onto several pages, which can be accessed by adding a 'page' param to the query.
#'
#' Rover Cameras: Curiousity, Opportunity, Spirit
#'
#' FHAZ: Front Hazard Avoidance Camera -> Curiousity, Opportunity, Spirit
#'
#' RHAZ: Rear Hazard Avoidance Camera -> Curiousity, Opportunity, Spirit
#'
#' MAST: Mast Camera -> Curiousity
#'
#' CHEMCAM: Chemistry and Camera Complex -> Curiousity
#'
#' MAHLI: Mars Hand Lens Imager -> Curiousity
#'
#' MARDI: Mars Descent Imager -> Curiousity
#'
#' NAVCAM: Navigation Camera -> Curiousity, Opportunity, Spirit
#'
#' PANCAM: Panoramic Camera -> Opportunity, Spirit
#'
#' MINITES: Miniature Thermal Emission Spectrometer (Mini-TES) -> Opportunity, Spirit
#'
#' @param key String. Your NASA API key, you can enter your key in the function parameter, but it's not recommended. Instead, you'd better save your key in R environment and call it "NASA_TOKEN". Then the function would automatically acquire your key info.
#' @param earth_date Date. Earth date that you want to query photos with. Format should be "YYYY-MM-DD".
#' @param camera String. See detail camera list for abbreviations and availability. "all" as default.
#' @param page Integer. 25 items per page returned. 1 as default.
#' @param type String. "curiosity"/"opportunity"/"spirit". "curiosity" as default.
#' @param download_image Boolean. Download the first(default) image of returned list. FALSE as default.
#' @return Info of Mars Rover photos (and downloaded image).
#' @examples
#' MRP_date(earth_date = "2015-06-03")
#' MRP_date(earth_date = "2019-05-01", download_image = TRUE)
#' @export
MRP_date <- function(key = Sys.getenv("NASA_TOKEN"), earth_date, camera = "all", page = 1, type = "curiosity", download_image = FALSE){
  library(httr)
  library(jpeg)
  if (type == "curiousity"){
    type <- "curiosity"
  }
  url <- "https://api.nasa.gov/mars-photos/api/v1/rovers/"
  if (camera == "all"){
    url <- paste(url, type, "/photos?earth_date=", earth_date, "&api_key=", key, "&page=", page, sep = "")
  }else{
    url <- paste(url, type, "/photos?earth_date=", earth_date, "&api_key=", key, "&camera=", camera, "&page=", page, sep = "")
  }
  response <- GET(url)
  if (response$status_code != 200){
    message("Unsuccessful status of response!")
  }
  result <- content(response)
  if (download_image){
    download.file(result$photos[[1]]$img_src, "image.jpg", mode = 'wb')
    jpg <- readJPEG("image.jpg", native = TRUE)
    plot(0:1, 0:1, type = "n", ann = FALSE, axes = FALSE)
    rasterImage(jpg, 0, 0, 1, 1)
  }
  return(result)
}
