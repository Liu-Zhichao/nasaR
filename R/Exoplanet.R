#' Exoplanet: Access to NASA's Exoplanet Archive database
#'
#' This function allows programatic access to NASA's Exoplanet Archive database.
#' See detailed info at: https://exoplanetarchive.ipac.caltech.edu/docs/program_interfaces.html#data.
#'
#' @param table String. Specifies which table to query. "exoplanets" as default. Check the website for a full list of tables.
#' @param select String. Specifies which columns within the chosen table to return. Check the website for valid column names.
#' @param count Integer. Can be used to return the number of rows which fulfill the given query, including queries using where clauses or cone searches.
#' @param colset String. Returns a set of pre-defined columns that have been created by the archive. Currently, this keyword is only used by the Composite Planet Data (compositepars) table.
#' @param where String/A vector of strings. Specifies which rows to return. Use this to search for a range of values, such as rows with a declination greater than 0. Parameters must use a valid column name.
#' @param order String. Controls the order the rows are returned.
#' @param ra Number. Specifies an area of the sky to search for all objects within that area. Right Ascension (ra), Declination (dec) and radius (radius or rad) must be listed with their respective coordinates or units.
#' @param dec Number. Specifies an area of the sky to search for all objects within that area. Right Ascension (ra), Declination (dec) and radius (radius or rad) must be listed with their respective coordinates or units.
#' @param radius String. Specifies an area of the sky to search for all objects within that area. Right Ascension (ra), Declination (dec) and radius (radius or rad) must be listed with their respective coordinates or units. The units must be included in the radius specification (degrees, minutes, arcsecs) with a space preceding the unit name.
#' @param aliastable String. Requests a list of aliases for a particular confirmed planet.
#' @return Data from NASA's Exoplanet Archive database.
#' @examples
#' Exoplanet()
#' Exoplanet(select = "pl_hostname", order = "dec")
#' Exoplanet(ra = 291, dec = 48, radius = "1 degree")
#' Exoplanet(table = "cumulative", where = c("koi_prad<2", "koi_teq>180", "koi_teq<303", "koi_disposition like 'CANDIDATE'"))
#' Exoplanet(aliastable = "bet Pic")
#' @export
Exoplanet <- function(table = "exoplanets", select = NULL, count = NULL, colset = NULL, where = NULL,
                      order = NULL, ra = NULL, dec = NULL, radius = NULL, aliastable = NULL){
  library(tidyr)
  library(httr)
  library(jsonlite)
  library(stringr)
  url <- "https://exoplanetarchive.ipac.caltech.edu/cgi-bin/nstedAPI/nph-nstedAPI?" %>%
    paste(., "table=", table, sep = "")
  if (is.null(select) == FALSE){
    url <- paste(url, "&select=", select, sep = "")
  }
  if (is.null(count) == FALSE){
    url <- paste(url, "&select=count(", count, ")", sep = "")
  }
  if (is.null(colset) == FALSE){
    url <- paste(url, "&colset=", colset, sep = "")
  }
  if (is.null(where) == FALSE){
    where <- str_replace_all(where, "<", "%3C") %>%
      str_replace_all(., "=", "%3D") %>%
      str_replace_all(., ">", "%3E") %>%
      str_replace_all(., " ", "%20") %>%
      str_replace_all(., "'", "%27")
    if (length(where) == 1){
      url <- paste(url, "&where=", where, sep = "")
    }else{
      url <- paste(url, "&where=", where[1], sep = "")
      for (i in 2:length(where)){
        url <- paste(url, "%20and%20", where[i], sep = "")
      }
    }
  }
  if (is.null(order) == FALSE){
    url <- paste(url, "&order=", order, sep = "")
  }
  if (is.null(ra) == FALSE){
    url <- paste(url, "&ra=", ra, sep = "")
  }
  if (is.null(dec) == FALSE){
    url <- paste(url, "&dec=", dec, sep = "")
  }
  if (is.null(radius) == FALSE){
    radius <- str_replace_all(radius, " ", "%20")
    url <- paste(url, "&radius=", radius, sep = "")
  }
  if (is.null(aliastable) == FALSE){
    url <- paste("https://exoplanetarchive.ipac.caltech.edu/cgi-bin/nstedAPI/nph-nstedAPI?", "&table=aliastable&objname=", aliastable, sep = "")
  }
  url <- paste(url, "&format=json", sep = "") %>%
    str_replace_all(., " ", "%20")
  result <- read_json(url)
  return(result)
}
