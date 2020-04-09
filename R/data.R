#' COVID cases and deaths to April 2nd 2020
#'
#' A dataset containing national-level ECDC data on COVID-19
#'
#' @format A tibble with 2,646 rows and 8 columns
#' \describe{
#'   \item{date}{date in YYYY-MM-DD format}
#'   \item{cname}{Name of country (character)}
#'   \item{iso3}{ISO3 country code (character)}
#'   \item{cases}{N reported COVID-19 cases on this date}
#'   \item{deaths}{N reported COVID-19 deaths on this date}
#'   \item{cu_cases}{Cumulative N reported COVID-19 cases up to and including this date}
#'   \item{cu_deaths}{Cumulative N reported COVID-19 deaths up to and including this date}
#'   \item{days_elapsed}{Days elapsed since first reported event}
#' }
#' @source \url{http://ecdc.europa.eu/}
"covcurve"
