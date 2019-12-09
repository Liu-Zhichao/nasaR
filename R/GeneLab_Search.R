#' GeneLab_Search: Programmatic interface for GeneLab's public data repository website
#'
#' GeneLab provides a RESTful Application Programming Interface (API) to its full-text search capability,
#' which provides the same functionality available through the GeneLab public data repository website.
#' The API provides a choice of standardized web output formats, such as JavaScript Object Notation (JSON) or
#' Hyper Text Markup Language (HTML), of the search results. The GeneLab Search API can also federate with other
#' heterogeneous external bioinformatics databases, such as the National Institutes of Health (NIH) / National Center for
#' Biotechnology Information's (NCBI) Gene Expression Omnibus (GEO); the European Bioinformatics Institute's (EBI) Proteomics Identification (PRIDE);
#' the Argonne National Laboratory's (ANL) Metagenomics Rapid Annotations using Subsystems Technology (MG-RAST).
#'
#' @param key String. Your NASA API key, you can enter your key in the function parameter, but it's not recommended. Instead, you'd better save your key in R environment and call it "NASA_TOKEN". Then the function would automatically acquire your key info.
#' @param term String (optional multiple values). Keyword(s) to search on along with optional case-insensitive boolean operators, such as: AND, OR, NOT (Note: Default search is a boolean "AND" for all keyword searches). Query all GeneLab data sets as default.
#' @param type String (multiple valid values: cgene, nih_geo_gse, ebi_pride, mg_rast). Specific database(s) to query on (e.g., values available cgene=GeneLab, nih_geo_gse=NIH GEO, ebi_pride=EBI PRIDE, or mg_rast=MG-RAST database with optional multiple values separated by comma delimiter). "cgene" (GeneLab database) as default.
#' @param from Integer. Search result sets pagination start page. 0 as default.
#' @param size Integer. Search result sets display count. 25 as default.
#' @param order String. Sort order (e.g., either "ASC" for ascending or "DESC" for descending). "DESC" as default.
#' @param ffield String. Search filter field is only for GeneLab database (cgene) at this time. Other databases will be included at a later time. (should always be paired with fvalue parameter).
#' @param fvalue String. Search filter value is only for GeneLab database (cgene) at this time. Other databases will be included at a later time. (should always be paired with ffield parameter).
#' @return Data from GeneLab website.
#' @examples
#' GeneLab_Search(term = "space", ffield = "links", fvalue = "GPL16417", type = "cgene,nih_geo_gse")
#' GeneLab_Search(ffield = "Accession", fvalue = "GSE82255")
#' @export
GeneLab_Search <- function(key = Sys.getenv("NASA_TOKEN"), term = "", type = "cgene", from = 0, size = 25, order = "DESC", ffield, fvalue){
  library(httr)
  url <- "https://genelab-data.ndc.nasa.gov/genelab/data/search?"
  if (term == ""){
    url <- paste(url, "api_key=", key, "&type=", type, "&from=", from, "&size=", size, "&order=", order, "&ffield=", ffield, "&fvalue=", fvalue, sep = "")
  }else{
    url <- paste(url, "api_key=", key, "&term=", term, "&type=", type, "&from=", from, "&size=", size, "&order=", order, "&ffield=", ffield, "&fvalue=", fvalue, sep = "")
  }
  response <- GET(url)
  if (response$status_code != 200){
    message("Unsuccessful status of response!")
  }
  result <- content(response)
  return(result)
}
