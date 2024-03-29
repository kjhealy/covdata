% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{nytcovstate}
\alias{nytcovstate}
\title{NYT COVID-19 data for the US states, current as of Sunday, January 22, 2023}
\format{
A tibble with 58,526 rows and 5 columns
\describe{
\item{date}{Date in YYYY-MM-DD format (date)}
\item{state}{State name (character)}
\item{fips}{State FIPS code (character)}
\item{cases}{Cumulative N  reported cases}
\item{deaths}{Cumulative N reported deaths}
}
}
\source{
The New York Times \url{https://github.com/nytimes/covid-19-data}.
For details on the methods and limitations see \url{https://github.com/nytimes/covid-19-data}.
}
\usage{
nytcovstate
}
\description{
A dataset containing US state-level data on COVID-19, collected by the New York Times.
}
\details{
Table: Data summary\tabular{ll}{
    \tab  \cr
   Name \tab nytcovstate \cr
   Number of rows \tab 58526 \cr
   Number of columns \tab 5 \cr
   _______________________ \tab  \cr
   Column type frequency: \tab  \cr
   Date \tab 1 \cr
   character \tab 2 \cr
   numeric \tab 2 \cr
   ________________________ \tab  \cr
   Group variables \tab None \cr
}


\strong{Variable type: Date}\tabular{lrrlllr}{
   skim_variable \tab n_missing \tab complete_rate \tab min \tab max \tab median \tab n_unique \cr
   date \tab 0 \tab 1 \tab 2020-01-21 \tab 2023-01-21 \tab 2021-08-16 \tab 1097 \cr
}


\strong{Variable type: character}\tabular{lrrrrrrr}{
   skim_variable \tab n_missing \tab complete_rate \tab min \tab max \tab empty \tab n_unique \tab whitespace \cr
   state \tab 0 \tab 1 \tab 4 \tab 24 \tab 0 \tab 56 \tab 0 \cr
   fips \tab 0 \tab 1 \tab 2 \tab 2 \tab 0 \tab 56 \tab 0 \cr
}


\strong{Variable type: numeric}\tabular{lrrrrrrrrrl}{
   skim_variable \tab n_missing \tab complete_rate \tab mean \tab sd \tab p0 \tab p25 \tab p50 \tab p75 \tab p100 \tab hist \cr
   cases \tab 0 \tab 1 \tab 834511.91 \tab 1394631.70 \tab 1 \tab 64160 \tab 324958 \tab 985279.8 \tab 11955605 \tab ▇▁▁▁▁ \cr
   deaths \tab 0 \tab 1 \tab 11294.84 \tab 16797.98 \tab 0 \tab 1080 \tab 4790 \tab 14373.0 \tab 101982 \tab ▇▁▁▁▁ \cr
}
}
\keyword{datasets}
