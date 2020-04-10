#' International COVID-19 cases and deaths, current as of `r format(Sys.Date(), "%A, %B %e, %Y")`
#'
#' A dataset containing national-level ECDC data on COVID-19
#'
#' @format A tibble with `r nrow(covnat)` rows and `r ncol(covnat)` columns
#' \describe{
#'   \item{date}{date in YYYY-MM-DD format}
#'   \item{cname}{Name of country (character)}
#'   \item{iso3}{ISO3 country code (character)}
#'   \item{cases}{N reported COVID-19 cases on this date}
#'   \item{deaths}{N reported COVID-19 deaths on this date}
#'   \item{pop_2018}{Country population in 2018}
#'   \item{cu_cases}{Cumulative N reported COVID-19 cases up to and including this date}
#'   \item{cu_deaths}{Cumulative N reported COVID-19 deaths up to and including this date}
#' }
#' @source \url{http://ecdc.europa.eu/}
"covnat"

#' COVID-19 data for the USA, current as of `r format(Sys.Date(), "%A, %B %e, %Y")`
#'
#' A dataset containing US state-level data on COVID-19
#'
#' @format A tibble with `r nrow(covus)` rows and `r ncol(covus)` columns
#' \describe{
#' \item{date}{Date in YYYY-MM-DD format (date)}
#' \item{state}{Two letter State abbreviation (character)}
#' \item{fips}{State FIPS code (character)}
#' \item{measure}{Outcome measure for this date}
#' \item{count}{Count of measure}
#' \item{pos_neg}{}
#' \item{death_increase}{}
#' \item{hospitalized_increase}{}
#' \item{negative_increase}{}
#' \item{positive_increase}{}
#' \item{total_test_results_increase}{}
#' }
#' @source The COVID-19 Tracking Project \url{https://covidtracking.com}
"covus"

#' NYT COVID-19 data for US counties, current as of `r format(Sys.Date(), "%A, %B %e, %Y")`
#'
#' A dataset containing US county-level data on COVID-19, collected by the New York Times.
#'
#' @format A tibble with `r nrow(nytcovcounty)` rows and `r ncol(nytcovcounty)` columns
#' \describe{
#' \item{date}{Date in YYYY-MM-DD format (date)}
#' \item{county}{County name (character)}
#' \item{state}{State name (character)}
#' \item{fips}{County FIPS code (character)}
#' \item{cases}{Cumulative N reported cases}
#' \item{deaths}{Cumulative N reported deaths}
#' }
#' @source The New York Times \url{https://github.com/nytimes/covid-19-data}
#' For details on the methods and limitations see \\url{https://github.com/nytimes/covid-19-data}.
#' For county data, note in particular:
#' - New York: All cases for the five boroughs of New York City (New York, Kings, Queens, Bronx and Richmond counties) are assigned to a single area called New York City. There is a large jump in the number of deaths on April 6th due to switching from data from New York City to data from New York state for deaths. For all New York state counties, starting on April 8th we are reporting deaths by place of fatality instead of residence of individual.
#' - Kansas City, Mo: Four counties (Cass, Clay, Jackson and Platte) overlap the municipality of Kansas City, Mo. The cases and deaths that we show for these four counties are only for the portions exclusive of Kansas City. Cases and deaths for Kansas City are reported as their own line.
#' - Alameda County, Calif: Counts for Alameda County include cases and deaths from Berkeley and the Grand Princess cruise ship.
#' - Douglas County, Neb. Counts for Douglas County include cases brought to the state from the Diamond Princess cruise ship.
#' - Chicago: All cases and deaths for Chicago are reported as part of Cook County.
#' - Guam: Counts for Guam include cases reported from the USS Theodore Roosevelt.
"nytcovcounty"

#' NYT COVID-19 data for the US states, current as of `r format(Sys.Date(), "%A, %B %e, %Y")`
#'
#' A dataset containing US state-level data on COVID-19, collected by the New York Times.
#'
#' @format A tibble with `r nrow(nytcovstate)` rows and `r ncol(nytcovstate)` columns
#' \describe{
#' \item{date}{Date in YYYY-MM-DD format (date)}
#' \item{state}{State name (character)}
#' \item{fips}{State FIPS code (character)}
#' \item{cases}{Cumulative N  reported cases}
#' \item{deaths}{Cumulative N reported deaths}
#' }
#'
#' @source The New York Times \url{https://github.com/nytimes/covid-19-data}.
#' For details on the methods and limitations see \url{https://github.com/nytimes/covid-19-data}.
"nytcovstate"

