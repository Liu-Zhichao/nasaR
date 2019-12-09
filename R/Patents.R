#' Patents: Structured, searchable developer access to NASA's patents. **** THIS IS DOWN CURRENTLY. ****
#'
#' NOTE: THIS IS DOWN CURRENTLY: The NASA patent portfolio is available to benefit US citizens.
#' Through partnerships and licensing agreements with industry, these patents ensure that NASA’s
#' investments in pioneering research find secondary uses that benefit the economy, create jobs,
#' and improve quality of life. This function provides structured, searchable developer access to
#' NASA’s patents that have been curated to support technology transfer.
#'
#' @param key String. Your NASA API key, you can enter your key in the function parameter, but it's not recommended. Instead, you'd better save your key in R environment and call it "NASA_TOKEN". Then the function would automatically acquire your key info.
#' @param query String. Search text to filter results.
#' @param concept_tags Boolean. Return an ordered dictionary of concepts from the patent abstract. FALSE as default.
#' @param limit Integer. number of patents to return. 5 as default.
#' @examples
#' Patents(query = "temperature")
#' @export
Patents <- function(key = Sys.getenv("NASA_TOKEN"), query, concept_tags = FALSE, limit = 5){
  library(tidyr)
  library(httr)
  response <- "https://api.nasa.gov/patents/content?" %>%
    paste(., "query=", query, "&concept_tags=", concept_tags, "&limit=", limit, "&api_key=", key, sep = "") %>%
    GET(.)
  if (response$status_code != 200){
    message("THIS API IS NOW DOWN!!!")
  }
  result <- content(response)
  return(result)
}
