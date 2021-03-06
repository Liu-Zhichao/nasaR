% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Patents.R
\name{Patents}
\alias{Patents}
\title{Patents: Structured, searchable developer access to NASA's patents. **** THIS IS DOWN CURRENTLY. ****}
\usage{
Patents(key = Sys.getenv("NASA_TOKEN"), query, concept_tags = FALSE,
  limit = 5)
}
\arguments{
\item{key}{String. Your NASA API key, you can enter your key in the function parameter, but it's not recommended. Instead, you'd better save your key in R environment and call it "NASA_TOKEN". Then the function would automatically acquire your key info.}

\item{query}{String. Search text to filter results.}

\item{concept_tags}{Boolean. Return an ordered dictionary of concepts from the patent abstract. FALSE as default.}

\item{limit}{Integer. number of patents to return. 5 as default.}
}
\value{
Data of NASA's patents.
}
\description{
NOTE: THIS IS DOWN CURRENTLY: The NASA patent portfolio is available to benefit US citizens.
Through partnerships and licensing agreements with industry, these patents ensure that NASA’s
investments in pioneering research find secondary uses that benefit the economy, create jobs,
and improve quality of life. This function provides structured, searchable developer access to
NASA’s patents that have been curated to support technology transfer.
}
\examples{
Patents(query = "temperature")
}
