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
#' }
#' @details The measures tracked by the COVID tracking project are as follows:
#' - `positive` Total cumulative positive test results.
#' - `positive_increase` Increase in positive cases from the day before.
#' - `negative` Total cumulative negative test results.
#' - `negative_increase` Increase in negative cases from the day before.
#' - `pending` Tests that have been submitted to a lab but no results have been reported yet.
#' - `hospitalized_currently` Total number of people hospitalized on date.
#' - `hospitalized_cumulative` Total cumulative number of people hospitalized by date.
#' - `in_icu_currently`  Total number of people in intensive care unit on date.
#' - `in_icu_cumulative` Total cumulative number of people in intensive care unit by date.
#' - `on_ventilator_currently`  Total number of people on ventilator on date.
#' - `on_ventilator_cumulative` Total cumulative number of people on ventilator by date.
#' - `recovered` Total number recovered.
#' - `death` Total number of deaths.
#' - `death_increase` Increase in deaths from the day before.
#' - `total_test_results` Calculated value (positive + negative) of total test results.
#' - `total_test_results_increase` Increase in total test results from the day before
#' Not all measures are reported by all states.
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
#' For details on the methods and limitations see \url{https://github.com/nytimes/covid-19-data}.
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

#' NYT COVID-19 data for the US, current as of `r format(Sys.Date(), "%A, %B %e, %Y")`
#'
#' A dataset containing US national-level data on COVID-19, collected by the New York Times.
#'
#' @format A tibble with `r nrow(nytcovus)` rows and `r ncol(nytcovus)` columns
#' \describe{
#' \item{date}{Date in YYYY-MM-DD format (date)}
#' \item{cases}{Cumulative N  reported cases}
#' \item{deaths}{Cumulative N reported deaths}
#' }
#'
#' @source The New York Times \url{https://github.com/nytimes/covid-19-data}.
#' For details on the methods and limitations see \url{https://github.com/nytimes/covid-19-data}.
"nytcovus"


#' @title CDC Laboratory Confirmed COVID-19-Associated Hospitalization in the US
#' @description Courtesy of Bob Rudis's cdccovidview package
#' @format A data frame with 4590 rows and 8 variables:
#' \describe{
#'   \item{\code{catchment}}{character COLUMN_DESCRIPTION}
#'   \item{\code{network}}{character COLUMN_DESCRIPTION}
#'   \item{\code{year}}{character COLUMN_DESCRIPTION}
#'   \item{\code{mmwr_year}}{character COLUMN_DESCRIPTION}
#'   \item{\code{mmwr_week}}{character COLUMN_DESCRIPTION}
#'   \item{\code{age_category}}{character COLUMN_DESCRIPTION}
#'   \item{\code{cumulative_rate}}{double COLUMN_DESCRIPTION}
#'   \item{\code{weekly_rate}}{double COLUMN_DESCRIPTION}
#'}
#' @details The U.S. Centers for Disease Control provides weekly
#' summary and interpretation of key indicators that have been adapted
#' to track the COVID-19 pandemic in the United States. Data is
#' retrieved using the cdccovidview package from both COVIDView
#' (<https://www.cdc.gov/coronavirus/2019-ncov/covid-data/covidview/index.html>)
#' and COVID-NET
#' (<https://gis.cdc.gov/grasp/COVIDNet/COVID19_3.html>).
#' @source Courtesy of Bob Rudis's cdccovidview package
#' @references <https://www.cdc.gov/coronavirus/2019-ncov/covid-data/covidview/index.html>
#' @author Kieran Healy
"cdc_hospitalizations"


#' @title CDC Provisional death counts by week
#' @description Provisional Death Counts for Coronavirus Disease (COVID-19)
#' @format A data frame with 10 rows and 7 variables:
#' \describe{
#'   \item{\code{week}}{double COLUMN_DESCRIPTION}
#'   \item{\code{covid_deaths}}{integer COLUMN_DESCRIPTION}
#'   \item{\code{total_deaths}}{integer COLUMN_DESCRIPTION}
#'   \item{\code{percent_expected_deaths}}{double COLUMN_DESCRIPTION}
#'   \item{\code{pneumonia_deaths}}{integer COLUMN_DESCRIPTION}
#'   \item{\code{pneumonia_and_covid_deaths}}{integer COLUMN_DESCRIPTION}
#'   \item{\code{all_influenza_deaths_j09_j11}}{integer COLUMN_DESCRIPTION}
#'}
#' @details The U.S. Centers for Disease Control provides weekly
#' summary and interpretation of key indicators that have been adapted
#' to track the COVID-19 pandemic in the United States. Data is
#' retrieved using the cdccovidview package from both COVIDView
#' (<https://www.cdc.gov/coronavirus/2019-ncov/covid-data/covidview/index.html>)
#' and COVID-NET
#' (<https://gis.cdc.gov/grasp/COVIDNet/COVID19_3.html>). Please see the indicated reference for all the caveats and precise meanings for each field.
#' @references <https://data.cdc.gov/api/views/hc4f-j6nb/rows.csv?accessType=DOWNLOAD&bom=true&format=true>
#' @source Courtesy of Bob Rudis's cdccovidview package
#' @author Kieran Healy
"cdc_deaths_by_week"

#' @title CDC Surveillance Network Death Counts by Age
#' @description Provisional Death Counts for Coronavirus Disease (COVID-19)
#' @format A data frame with 12 rows and 7 variables:
#' \describe{
#'   \item{\code{age_group}}{character COLUMN_DESCRIPTION}
#'   \item{\code{covid_deaths}}{integer COLUMN_DESCRIPTION}
#'   \item{\code{total_deaths}}{integer COLUMN_DESCRIPTION}
#'   \item{\code{percent_expected_deaths}}{double COLUMN_DESCRIPTION}
#'   \item{\code{pneumonia_deaths}}{integer COLUMN_DESCRIPTION}
#'   \item{\code{pneumonia_and_covid_deaths}}{integer COLUMN_DESCRIPTION}
#'   \item{\code{all_influenza_deaths_j09_j11}}{integer COLUMN_DESCRIPTION}
#'}
#' @details The U.S. Centers for Disease Control provides weekly
#' summary and interpretation of key indicators that have been adapted
#' to track the COVID-19 pandemic in the United States. Data is
#' retrieved using the cdccovidview package from both COVIDView
#' (<https://www.cdc.gov/coronavirus/2019-ncov/covid-data/covidview/index.html>)
#' and COVID-NET
#' (<https://gis.cdc.gov/grasp/COVIDNet/COVID19_3.html>). Please see the indicated reference for all the caveats and precise meanings for each field.
#' @references <https://data.cdc.gov/api/views/hc4f-j6nb/rows.csv?accessType=DOWNLOAD&bom=true&format=true>
#' @source Courtesy of Bob Rudis's cdccovidview package
#' @author Kieran Healy
"cdc_deaths_by_age"

#' @title CDC provisional death counts by sex
#' @description Provisional Death Counts for Coronavirus Disease (COVID-19)
#' @format A data frame with 3 rows and 7 variables:
#' \describe{
#'   \item{\code{sex}}{character COLUMN_DESCRIPTION}
#'   \item{\code{covid_deaths}}{integer COLUMN_DESCRIPTION}
#'   \item{\code{total_deaths}}{integer COLUMN_DESCRIPTION}
#'   \item{\code{percent_expected_deaths}}{double COLUMN_DESCRIPTION}
#'   \item{\code{pneumonia_deaths}}{integer COLUMN_DESCRIPTION}
#'   \item{\code{pneumonia_and_covid_deaths}}{integer COLUMN_DESCRIPTION}
#'   \item{\code{all_influenza_deaths_j09_j11}}{integer COLUMN_DESCRIPTION}
#'}
#' @details The U.S. Centers for Disease Control provides weekly
#' summary and interpretation of key indicators that have been adapted
#' to track the COVID-19 pandemic in the United States. Data is
#' retrieved using the cdccovidview package from both COVIDView
#' (<https://www.cdc.gov/coronavirus/2019-ncov/covid-data/covidview/index.html>)
#' and COVID-NET
#' (<https://gis.cdc.gov/grasp/COVIDNet/COVID19_3.html>). Please see the indicated reference for all the caveats and precise meanings for each field.
#' @references <https://data.cdc.gov/api/views/hc4f-j6nb/rows.csv?accessType=DOWNLOAD&bom=true&format=true>
#' @source Courtesy of Bob Rudis's cdccovidview package
#' @author Kieran Healy
"cdc_deaths_by_sex"

#' @title CDC provisional death counts by state
#' @description CDC Surveillance Network provisional death counts
#' @format A data frame with 53 rows and 7 variables:
#' \describe{
#'   \item{\code{state}}{character COLUMN_DESCRIPTION}
#'   \item{\code{covid_deaths}}{integer COLUMN_DESCRIPTION}
#'   \item{\code{total_deaths}}{integer COLUMN_DESCRIPTION}
#'   \item{\code{percent_expected_deaths}}{double COLUMN_DESCRIPTION}
#'   \item{\code{pneumonia_deaths}}{integer COLUMN_DESCRIPTION}
#'   \item{\code{pneumonia_and_covid_deaths}}{integer COLUMN_DESCRIPTION}
#'   \item{\code{all_influenza_deaths_j09_j11}}{integer COLUMN_DESCRIPTION}
#'}
#' @details The U.S. Centers for Disease Control provides weekly
#' summary and interpretation of key indicators that have been adapted
#' to track the COVID-19 pandemic in the United States. Data is
#' retrieved using the cdccovidview package from both COVIDView
#' (<https://www.cdc.gov/coronavirus/2019-ncov/covid-data/covidview/index.html>)
#' and COVID-NET. Please see the indicated reference for all the caveats and precise meanings for each field.
#' (<https://gis.cdc.gov/grasp/COVIDNet/COVID19_3.html>).
#' @references <https://data.cdc.gov/api/views/hc4f-j6nb/rows.csv?accessType=DOWNLOAD&bom=true&format=true>
#' @author Kieran Healy
"cdc_deaths_by_state"

#' @title CDC surveillance network and network catchment area
#' @description What the CDC surveillance network covers
#' @format A data frame with 17 rows and 2 variables: \describe{ \item{\code{name}}{character COLUMN_DESCRIPTION} \item{\code{area}}{character COLUMN_DESCRIPTION} }
#' @details The Coronavirus Disease 2019 (COVID-19)-Associated Hospitalization Surveillance Network (COVID-NET) conducts population-based surveillance for laboratory-confirmed COVID-19-associated hospitalizations in children (persons younger than 18 years) and adults. The current network covers nearly 100 counties in the 10 Emerging Infections Program (EIP) states (CA, CO, CT, GA, MD, MN, NM, NY, OR, and TN) and four additional states through the Influenza Hospitalization Surveillance Project (IA, MI, OH, and UT). The network represents approximately 10% of US population (~32 million people). Cases are identified by reviewing hospital, laboratory, and admission databases and infection control logs for patients hospitalized with a documented positive SARS-CoV-2 test. Data gathered are used to estimate age-specific hospitalization rates on a weekly basis and describe characteristics of persons hospitalized with COVID-19. Laboratory confirmation is dependent on clinician-ordered SARS-CoV-2 testing. Therefore, the unadjusted rates provided are likely to be underestimated as COVID-19-associated hospitalizations can be missed due to test availability and provider or facility testing practices. COVID-NET hospitalization data are preliminary and subject to change as more data become available. All incidence rates are unadjusted. Please use the following citation when referencing these data: “COVID-NET: COVID-19-Associated Hospitalization Surveillance Network, Centers for Disease Control and Prevention. WEBSITE. Accessed on DATE”.
#' @source Courtesy of Bob Rudis's cdccovidview package
#' @references <https://www.cdc.gov/coronavirus/2019-ncov/covid-data/covidview/index.html>
#' @author Kieran Healy
"cdc_catchments"

#' @title NSSP National COVID-related ER Visits
#' @description National Syndromic Surveillance Program (NSSP):
#' Emergency Department Visits and Percentage of Visits for COVID-19-Like Illness (CLI) or Influenza-like Illness (ILI)
#' @format A data frame with 54 rows and 9 variables:
#' \describe{
#'   \item{\code{week}}{integer COLUMN_DESCRIPTION}
#'   \item{\code{num_fac}}{integer COLUMN_DESCRIPTION}
#'   \item{\code{total_ed_visits}}{character COLUMN_DESCRIPTION}
#'   \item{\code{visits}}{integer COLUMN_DESCRIPTION}
#'   \item{\code{pct_visits}}{double COLUMN_DESCRIPTION}
#'   \item{\code{visit_type}}{character COLUMN_DESCRIPTION}
#'   \item{\code{region}}{character COLUMN_DESCRIPTION}
#'   \item{\code{source}}{character COLUMN_DESCRIPTION}
#'   \item{\code{year}}{integer COLUMN_DESCRIPTION}
#'}
#' @details The U.S. Centers for Disease Control provides weekly
#' summary and interpretation of key indicators that have been adapted
#' to track the COVID-19 pandemic in the United States. Data is
#' retrieved using the cdccovidview package from both COVIDView
#' (<https://www.cdc.gov/coronavirus/2019-ncov/covid-data/covidview/index.html>)
#' and COVID-NET
#' (<https://gis.cdc.gov/grasp/COVIDNet/COVID19_3.html>).
#' @source Courtesy of Bob Rudis's cdccovidview package
#' @references <https://www.cdc.gov/coronavirus/2019-ncov/covid-data/covidview/04102020/nssp-regions.html>
#' @author Kieran Healy
"nssp_covid_er_nat"

#' @title NSSP Regional COVID ER Visits
#' @description Regional Syndromic Surveillance Program (NSSP):
#' Emergency Department Visits and Percentage of Visits for COVID-19-Like Illness (CLI) or Influenza-like Illness (ILI)
#' @format A data frame with 538 rows and 9 variables:
#' \describe{
#'   \item{\code{week}}{integer COLUMN_DESCRIPTION}
#'   \item{\code{num_fac}}{integer COLUMN_DESCRIPTION}
#'   \item{\code{total_ed_visits}}{character COLUMN_DESCRIPTION}
#'   \item{\code{visits}}{integer COLUMN_DESCRIPTION}
#'   \item{\code{pct_visits}}{double COLUMN_DESCRIPTION}
#'   \item{\code{visit_type}}{character COLUMN_DESCRIPTION}
#'   \item{\code{region}}{character COLUMN_DESCRIPTION}
#'   \item{\code{source}}{character COLUMN_DESCRIPTION}
#'   \item{\code{year}}{integer COLUMN_DESCRIPTION}
#'}
#' @details The U.S. Centers for Disease Control provides weekly
#' summary and interpretation of key indicators that have been adapted
#' to track the COVID-19 pandemic in the United States. Data is
#' retrieved using the cdccovidview package from both COVIDView
#' (<https://www.cdc.gov/coronavirus/2019-ncov/covid-data/covidview/index.html>)
#' and COVID-NET
#' (<https://gis.cdc.gov/grasp/COVIDNet/COVID19_3.html>).
#' @references <https://www.cdc.gov/coronavirus/2019-ncov/covid-data/covidview/04102020/nssp-regions.html>
#' @source Courtesy of Bob Rudis's cdccovidview package
#' @author Kieran Healy
"nssp_covid_er_reg"


