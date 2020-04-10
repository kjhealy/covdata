#' International COVID-19 cases and deaths to April 9th 2020
#'
#' A dataset containing national-level ECDC data on COVID-19
#'
#' @format A tibble with 9,653 rows and 10 columns
#' \describe{
#'   \item{date}{date in YYYY-MM-DD format}
#'   \item{cname}{Name of country (character)}
#'   \item{iso3}{ISO3 country code (character)}
#'   \item{cases}{N reported COVID-19 cases on this date}
#'   \item{deaths}{N reported COVID-19 deaths on this date}
#'   \item{pop_2018}{Country population in 2018}
#'   \item{cu_cases}{Cumulative N reported COVID-19 cases up to and including this date}
#'   \item{cu_deaths}{Cumulative N reported COVID-19 deaths up to and including this date}
#'   \item{days_elapsed}{Days elapsed since first reported event (duration)}
#'   \item{end_label}{Country name for most recent date only, else NA (character)}
#' }
#' @source \url{http://ecdc.europa.eu/}
"covnat"

#' COVID-19 data for the USA to April 9th 2020
#'
#' A dataset containing US state-level data on COVID-19
#'
#' @format A tibble with 27,216 rows and 11 columns
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
