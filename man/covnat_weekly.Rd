% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{covnat_weekly}
\alias{covnat_weekly}
\title{Weekly International COVID-19 cases and deaths, current as of Sunday, January 22, 2023}
\format{
A tibble with 4,966 rows and 11 columns
\describe{
\item{date}{date in YYYY-MM-DD format}
\item{year_week}{Year and week of reporting (character, YYYY-WW)}
\item{cname}{Name of country (character)}
\item{pop}{Country population from Eurostat or UN data}
\item{iso3}{ISO3 country code (character)}
\item{cases}{N reported COVID-19 cases for this week}
\item{deaths}{N reported COVID-19 deaths for this week}
\item{cu_cases}{Cumulative N reported COVID-19 cases up to and including this week}
\item{cu_deaths}{Cumulative N reported COVID-19 deaths up to and including this week}
\item{r14_cases}{14-day notification rate of reported COVID-19 cases per 100,000 population}
\item{r14_deaths}{14-day notification rate of reported COVID-19 cases per 100,000 population}
}
}
\source{
\url{http://ecdc.europa.eu/}
}
\usage{
covnat_weekly
}
\description{
A dataset containing weekly national-level ECDC data on COVID-19
}
\details{
Table: Data summary\tabular{ll}{
    \tab  \cr
   Name \tab dplyr::ungroup(covnat_wee... \cr
   Number of rows \tab 4966 \cr
   Number of columns \tab 11 \cr
   _______________________ \tab  \cr
   Column type frequency: \tab  \cr
   Date \tab 1 \cr
   character \tab 3 \cr
   numeric \tab 7 \cr
   ________________________ \tab  \cr
   Group variables \tab None \cr
}


\strong{Variable type: Date}\tabular{lrrlllr}{
   skim_variable \tab n_missing \tab complete_rate \tab min \tab max \tab median \tab n_unique \cr
   date \tab 0 \tab 1 \tab 2019-12-30 \tab 2023-01-09 \tab 2021-07-05 \tab 159 \cr
}


\strong{Variable type: character}\tabular{lrrrrrrr}{
   skim_variable \tab n_missing \tab complete_rate \tab min \tab max \tab empty \tab n_unique \tab whitespace \cr
   year_week \tab 0 \tab 1.00 \tab 7 \tab 7 \tab 0 \tab 159 \tab 0 \cr
   cname \tab 0 \tab 1.00 \tab 5 \tab 14 \tab 0 \tab 31 \tab 0 \cr
   iso3 \tab 196 \tab 0.96 \tab 3 \tab 3 \tab 0 \tab 30 \tab 0 \cr
}


\strong{Variable type: numeric}\tabular{lrrrrrrrrrl}{
   skim_variable \tab n_missing \tab complete_rate \tab mean \tab sd \tab p0 \tab p25 \tab p50 \tab p75 \tab p100 \tab hist \cr
   pop \tab 0 \tab 1.00 \tab 31613614.13 \tab 85253844.55 \tab 39055 \tab 2108977.00 \tab 6916548.00 \tab 17475415.00 \tab 453006705.00 \tab ▇▁▁▁▁ \cr
   cases \tab 222 \tab 0.96 \tab 77511.62 \tab 374657.80 \tab 0 \tab 1127.00 \tab 5487.00 \tab 28342.00 \tab 9023067.00 \tab ▇▁▁▁▁ \cr
   deaths \tab 279 \tab 0.94 \tab 514.14 \tab 2005.64 \tab 0 \tab 8.00 \tab 46.00 \tab 250.50 \tab 28380.00 \tab ▇▁▁▁▁ \cr
   cu_cases \tab 222 \tab 0.96 \tab 4188407.63 \tab 16969793.99 \tab 0 \tab 43400.25 \tab 485047.50 \tab 2117551.00 \tab 183857564.00 \tab ▇▁▁▁▁ \cr
   cu_deaths \tab 279 \tab 0.94 \tab 44362.78 \tab 142967.65 \tab 0 \tab 651.00 \tab 6268.00 \tab 28807.00 \tab 1204878.00 \tab ▇▁▁▁▁ \cr
   r14_cases \tab 263 \tab 0.95 \tab 557.34 \tab 1044.46 \tab 0 \tab 51.61 \tab 216.74 \tab 576.99 \tab 13728.65 \tab ▇▁▁▁▁ \cr
   r14_deaths \tab 321 \tab 0.94 \tab 34.08 \tab 50.74 \tab 0 \tab 3.81 \tab 14.21 \tab 42.57 \tab 435.28 \tab ▇▁▁▁▁ \cr
}
}
\keyword{datasets}
