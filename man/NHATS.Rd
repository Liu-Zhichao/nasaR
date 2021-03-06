% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/NHATS.R
\name{NHATS}
\alias{NHATS}
\title{NHATS: Solar System Dynamics and Center for Near-Earth Object Studies - Human-accessible NEOs data}
\usage{
NHATS(mode = "S", dv = 12, dur = 450, stay = 8,
  launch = "2020-2045", h = NULL, occ = NULL, spk = NULL,
  des = NULL, plot = FALSE)
}
\arguments{
\item{mode}{String. Mode to select, "S" or "O". "S" as default.}

\item{dv}{Integer. Mode: S, O. Minimum total delta-V (km/s). Allowable values: 4,5,6,7,8,9,10,11,12. 12 as default.}

\item{dur}{Integer. Mode: S, O. Minimum total duration (days). Allowable values: 60,90,120,150,180,210,240,270,300,330,360,390,420,450. 450 as default.}

\item{stay}{Integer. Mode: S, O. Minimum stay (days). Allowable values: 8,16,24,32. 8 as default.}

\item{launch}{String. Mode: S, O. Launch window (year range). Allowable values: "2020-2025", "2025-2030", "2030-2035", "2035-2040", "2040-2045", "2020-2045". "2020-2045" as default.}

\item{h}{Integer. Mode: S. Object’s maximum absolute magnitude, H (mag). Allowable values: 16,17,18,19,20,21,22,23,24,25,26,27,28,29,30.}

\item{occ}{Integer. Mode: S. Object’s maximum orbit codition code (OCC). Allowable values: 0,1,2,3,4,5,6,7,8.}

\item{spk}{Integer. Mode: O. Select data for the object matching this SPK-ID (e.g., 2000433).}

\item{des}{String. Mode: O. Select data for the object matching this designation (e.g., "2015 AB" or "141P" or "433").}

\item{plot}{Boolean. Mode: O. Include base-64 encoded plot image file content via output field plot_base64. FALSE as default.}
}
\value{
Data of NHATS objects.
}
\description{
The NHATS API provides a method of requesting data from the NHATS-related tables in the SBDB. These data will primarily support the CNEOS “Accessible NEAs” web-page.
See detailed info at: https://ssd-api.jpl.nasa.gov/doc/nhats.html.
}
\details{
This API supports two query modes:

S - obtain summary data spanning all available NHATS object

O - obtain details related to a specified NHATS object
}
\examples{
##### Mode: S
NHATS(dv = 6, dur = 360, stay = 8, launch = "2020-2045", h = 26, occ = 7)
##### Mode: O
NHATS(mode = "O", des = "99942")
NHATS(mode = "O", des = "2000\%20SG344", dv = 6, dur = 360, stay = 8, launch = "2020-2045")
}
