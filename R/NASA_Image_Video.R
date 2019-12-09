#' NASA_Image_Video: NASA Image and Video Library
#'
#' Use this API(function) to access the NASA Image and Video Library site at http://images.nasa.gov.
#'
#' See detailed info at https://images.nasa.gov/docs/images.nasa.gov_api_docs.pdf.
#'
#' @param endpoint String. There are four possible endpoints: "search" (Performing a search), "asset" (Retrieving a media asset’s manifest), "metadata" (Retrieving a media asset’s metadata location), "captions" (Retrieving a video asset’s captions location).
#' @param nasa_id String. The media asset's NASA ID. Necessary when endpoint is "asset" or "metadata" or "captions".
#' @param q String. Free text search terms to compare to all indexed metadata. Necessary when endpoint is "search".
#' @param center String. NASA center which published the media. Optional.
#' @param description String. Terms to search for in “Description” fields. Optional.
#' @param description_508 String. Terms to search for in “508 Description” fields. Optional.
#' @param keywords String. Terms to search for in “Keywords” fields. Separate multiple values with commas. Optional.
#' @param location String. Terms to search for in “Location” fields. Optional.
#' @param media_type String. Media types to restrict the search to. Available types: “image”, “audio”. Separate multiple values with commas. Optional.
#' @param page Integer. Page number, starting at 1, of results to get. Optional.
#' @param photographer String. The primary photographer’s name. Optional.
#' @param secondary_creator String. A secondary photographer/videographer’s name. Optional.
#' @param title String. Terms to search for in “Title” fields. Optional.
#' @param year_start String. The start year for results. Format: YYYY. Optional.
#' @param year_end String. The end year for results. Format: YYYY. Optional.
#' @return Info of images/videos in NASA Image and Video Library.
#' @examples
#' NASA_Image_Video(endpoint = "search", q = "apollo%2011", description = "moon%20landing", media_type = "image")
#' NASA_Image_Video(endpoint = "asset", nasa_id = "as11-40-5874")
#' NASA_Image_Video(endpoint = "metadata", nasa_id = "as11-40-5874")
#' NASA_Image_Video(endpoint = "captions", nasa_id = "172_ISS-Slosh")
#' @export
NASA_Image_Video <- function(endpoint, nasa_id = NULL, q = NULL, center = NULL, description = NULL, description_508 = NULL, keywords = NULL, location = NULL, media_type = NULL, page = NULL, photographer = NULL, secondary_creator = NULL, title = NULL, year_start = NULL, year_end = NULL){
  library(tidyr)
  library(httr)
  if (endpoint == "asset" | endpoint == "metadata" | endpoint == "captions"){
    response <- "https://images-api.nasa.gov/" %>%
      paste(., endpoint, "/", nasa_id, sep = "") %>%
      GET(.)
    if (response$status_code != 200){
      message("Unsuccessful status of response!")
    }
    result <- content(response)
    return(result)
  }else{
    url <- "https://images-api.nasa.gov/search?q=" %>%
      paste(., q, sep = "")
    if (is.null(center) == FALSE){
      url <- paste(url, "&center=", center, sep = "")}
    if (is.null(description) == FALSE){
      url <- paste(url, "&description=", description, sep = "")}
    if (is.null(description_508) == FALSE){
      url <- paste(url, "&description_508=", description_508, sep = "")}
    if (is.null(keywords) == FALSE){
      url <- paste(url, "&keywords=", keywords, sep = "")}
    if (is.null(location) == FALSE){
      url <- paste(url, "&location=", location, sep = "")}
    if (is.null(media_type) == FALSE){
      url <- paste(url, "&media_type=", media_type, sep = "")}
    if (is.null(nasa_id) == FALSE){
      url <- paste(url, "&nasa_id=", nasa_id, sep = "")}
    if (is.null(page) == FALSE){
      url <- paste(url, "&page=", page, sep = "")}
    if (is.null(photographer) == FALSE){
      url <- paste(url, "&photographer=", photographer, sep = "")}
    if (is.null(secondary_creator) == FALSE){
      url <- paste(url, "&secondary_creator=", secondary_creator, sep = "")}
    if (is.null(title) == FALSE){
      url <- paste(url, "&title=", title, sep = "")}
    if (is.null(year_start) == FALSE){
      url <- paste(url, "&year_start=", year_start, sep = "")}
    if (is.null(year_end) == FALSE){
      url <- paste(url, "&year_end=", year_end, sep = "")}
    response <- GET(url)
    if (response$status_code != 200){
      message("Unsuccessful status of response!")
    }
    result <- content(response)
    return(result)
  }
}
