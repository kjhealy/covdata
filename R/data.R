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
