#' @title Country Names and ISO codes
#' @description Convenience table of country names and their abbreviated names
#' @format A data frame with `r fmt_nr(countries)` rows and `r fmt_nc(countries)` variables:
#' \describe{
#'   \item{\code{cname}}{character Country name}
#'   \item{\code{iso3}}{character ISO 3 designation}
#'   \item{\code{iso2}}{character ISO 2 designation}
#'   \item{\code{continent}}{Continent}
#'}
#' @details
#'
#' ```{r, results = "asis", echo = FALSE}
#' skimr::skim(dplyr::ungroup(countries))
#' ```
#'
#' Produced from the ECDC tables in the covdata package.
#' @author Kieran Healy
#' @references ISO 2: \url{https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2} ISO 3: \url{https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3}
"countries"

#' International COVID-19 cases and deaths, current as of `r format(Sys.Date(), "%A, %B %e, %Y")`
#'
#' A dataset containing weekly national-level ECDC data on COVID-19
#'
#' @format A tibble with `r fmt_nr(covnat)` rows and `r fmt_nc(covnat)` columns
#' \describe{
#'   \item{date}{date in YYYY-MM-DD format}
#'   \item{cname}{Name of country (character)}
#'   \item{iso3}{ISO3 country code (character)}
#'   \item{cases}{N reported COVID-19 cases for this week}
#'   \item{deaths}{N reported COVID-19 deaths for this week}
#'   \item{pop}{Country population in 2019}
#'   \item{cu_cases}{Cumulative N reported COVID-19 cases up to and including this week}
#'   \item{cu_deaths}{Cumulative N reported COVID-19 deaths up to and including this week}
#' }
#' @details
#' ```{r, results = "asis", echo = FALSE}
#' skimr::skim(dplyr::ungroup(covnat))
#' ```
#'
#' @source \url{http://ecdc.europa.eu/}
"covnat"

#' COVID-19 data for the USA, current as of `r format(Sys.Date(), "%A, %B %e, %Y")`
#'
#' A dataset containing US state-level data on COVID-19
#'
#' @format A tibble with `r fmt_nr(covus)` rows and `r fmt_nc(covus)` columns
#' \describe{
#' \item{date}{Date in YYYY-MM-DD format (date)}
#' \item{state}{Two letter State abbreviation (character)}
#' \item{fips}{State FIPS code (character)}
#' \item{\code{data_quality_grade}}{character Data quality as assessed by COVID Tracking Project staff}
#' \item{measure}{Outcome measure for this date}
#' \item{count}{Count of measure}
#' \item{\code{measure_label}}{character Outcome measure, suitable for use as a plot label}
#' }
#' @details
#'
#' ```{r, results = "asis", echo = FALSE}
#' skimr::skim(covus)
#' ```
#'
#' The measures tracked by the COVID tracking project are as follows:
#'
#' `r knitr::kable(unique(covus[, c("measure", "measure_label")]))`
#'
#' Not all measures are reported by all states.
#' The `positive`, `negative`, `death`, `death_confirmed`, `probable_cases` and `death_probable` measures are _cumulative_ counts.
#' `death_confirmed` is the total number deaths of individuals with COVID-19 infection confirmed by a laboratory test.
#' In states where the information is available, it tracks only those laboratory-confirmed deaths where COVID also contributed
#' to the death according to the death certificate. `death_probable` is the total number of deaths where COVID was listed as a
#' cause of death and there is not a laboratory test confirming COVID-19 infection.
#'
#' For further information on the COVID Tracking Project's measures, see \url{https://covidtracking.com/about-data/data-definitions}
#' @source The COVID-19 Tracking Project \url{https://covidtracking.com}
"covus"

#' @title COVID-19 case and death counts for the USA by race and state current as of `r format(Sys.Date(), "%A, %B %e, %Y")`
#' @description The COVID Racial Data Tracker advocates for, collects, publishes, and analyzes racial data on the pandemic across the United States.
#' It’s a collaboration between the COVID Tracking Project and the Boston University Center for Antiracist Research.
#' @format A tibble with `r fmt_nr(covus_race)` rows and `r fmt_nc(covus_race)` columns
#' \describe{
#'   \item{\code{date}}{date Data reported as of this date}
#'   \item{\code{state}}{character State}
#'   \item{\code{group}}{character Racial group}
#'   \item{\code{cases}}{integer Total cases, count}
#'   \item{\code{deaths}}{integer Total deaths, count}
#'   \item{\code{hosp}}{integer Total hospitalizations, count}
#'}
#' @details
#' ```{r, results = "asis", echo = FALSE}
#' skimr::skim(covus_race)
#' ```
#'
#' The `group` variable is coded as follows:
#'
#' `r knitr::kable(unique(covus_race[,"group"]), col.names = c("groups"))`
#'
#' AI/AN is American Indian/Alaska Native. NH/PI is Native Hawaiian/Pacific Islander.
#' State-level counts should be handled with care, given the widely varying population distribution of people of different racial backgrounds by state.
#' @author Kieran Healy
#' @source https://covidtracking.com/race
"covus_race"


#' @title COVID-19 case and death counts for the USA by Hispanic/Non-Hispanic ethnicity and state current as of `r format(Sys.Date(), "%A, %B %e, %Y")`
#' @description The COVID Racial Data Tracker advocates for, collects, publishes, and analyzes racial data on the pandemic across the United States.
#' It’s a collaboration between the COVID Tracking Project and the Boston University Center for Antiracist Research.
#' @format A tibble with `r fmt_nr(covus_ethnicity)` rows and `r fmt_nc(covus_ethnicity)` columns
#' \describe{
#'   \item{\code{date}}{date Data reported as of this date}
#'   \item{\code{state}}{character State}
#'   \item{\code{group}}{character Ethnic group}
#'   \item{\code{cases}}{integer Total cases, count}
#'   \item{\code{deaths}}{integer Total deaths, count}
#'   \item{\code{hosp}}{integer Total hospitalizations, count}
#'}
#' @details
#' ```{r, results = "asis", echo = FALSE}
#' skimr::skim(covus_ethnicity)
#' ```
#'
#' The `group` variable is coded as "Hispanic", "Non-Hispanic", or "Unknown". Hispanics may be of any race. State-level counts should
#' be handled with care, given the widely varying population distribution of people of different ethnic backgrounds by state.
#' @author Kieran Healy
#' @source https://covidtracking.com/race
"covus_ethnicity"


#' NYT COVID-19 data for US counties, current as of `r format(Sys.Date(), "%A, %B %e, %Y")`
#'
#' A dataset containing US county-level data on COVID-19, collected by the New York Times.
#'
#' @format A tibble with `r fmt_nr(nytcovcounty)` rows and `r fmt_nc(nytcovcounty)` columns
#' \describe{
#' \item{date}{Date in YYYY-MM-DD format (date)}
#' \item{county}{County name (character)}
#' \item{state}{State name (character)}
#' \item{fips}{County FIPS code (character)}
#' \item{cases}{Cumulative N reported cases}
#' \item{deaths}{Cumulative N reported deaths}
#' }
#' @details
#' ```{r, results = "asis", echo = FALSE}
#' skimr::skim(nytcovcounty)
#' ```
#'
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
#' @format A tibble with `r fmt_nr(nytcovstate)` rows and `r fmt_nc(nytcovstate)` columns
#' \describe{
#' \item{date}{Date in YYYY-MM-DD format (date)}
#' \item{state}{State name (character)}
#' \item{fips}{State FIPS code (character)}
#' \item{cases}{Cumulative N  reported cases}
#' \item{deaths}{Cumulative N reported deaths}
#' }
#' @details
#' ```{r, results = "asis", echo = FALSE}
#' skimr::skim(nytcovstate)
#' ```
#'
#' @source The New York Times \url{https://github.com/nytimes/covid-19-data}.
#' For details on the methods and limitations see \url{https://github.com/nytimes/covid-19-data}.
"nytcovstate"

#' NYT COVID-19 data for the US, current as of `r format(Sys.Date(), "%A, %B %e, %Y")`
#'
#' A dataset containing US national-level data on COVID-19, collected by the New York Times.
#'
#' @format A tibble with `r fmt_nr(nytcovus)` rows and `r fmt_nc(nytcovus)` columns
#' \describe{
#' \item{date}{Date in YYYY-MM-DD format (date)}
#' \item{cases}{Cumulative N  reported cases}
#' \item{deaths}{Cumulative N reported deaths}
#' }
#' @details
#' ```{r, results = "asis", echo = FALSE}
#' skimr::skim(nytcovus)
#' ```
#'
#' @source The New York Times \url{https://github.com/nytimes/covid-19-data}.
#' For details on the methods and limitations see \url{https://github.com/nytimes/covid-19-data}.
"nytcovus"


#' @title NYT Excess Mortality Estimates, current as of `r format(Sys.Date(), "%A, %B %e, %Y")`
#' @description All-cause mortality is widely used by demographers and other researchers to understand the full impact of deadly events, including epidemics, wars and natural disasters. The totals in this data include deaths from Covid-19 as well as those from other causes, likely including people who could not be treated or did not seek treatment for other conditions.
#' @format A tibble with `r fmt_nr(nytexcess)` rows and `r fmt_nc(nytexcess)` columns
#' \describe{
#'   \item{\code{country}}{character Country Name}
#'   \item{\code{placename}}{character Place Name}
#'   \item{\code{frequency}}{character Reporting period. Weekly or monthly, depending on how the data is recorded.}
#'   \item{\code{start_date}}{date The first date included in the period.}
#'   \item{\code{end_date}}{date The last date included in the period,}
#'   \item{\code{year}}{character Year of data. Note that this variable is of type character and not integer because several observations are notes to the effect that the year is an average of two years.}
#'   \item{\code{month}}{integer Numerical month.}
#'   \item{\code{week}}{integer Numerical week.}
#'   \item{\code{deaths}}{integer  The total number of confirmed deaths recorded from any cause.}
#'   \item{\code{expected_deaths}}{integer The baseline number of expected deaths, calculated from a historical average. See details below.}
#'   \item{\code{excess_deaths}}{integer The number of deaths minus the expected deaths.}
#'   \item{\code{baseline}}{character The years used to calculate expected_deaths.}
#'}
#' @details
#' ```{r, results = "asis", echo = FALSE}
#' skimr::skim(nytexcess)
#' ```
#'
#' Expected deaths for each area based on historical data for the same time of year. These expected deaths are the basis for our excess death calculations, which estimate how many more people have died this year than in an average year.
#'
#' The number of years used in the historical averages changes depending on what data is available, whether it is reliable and underlying demographic changes. See Data Sources for the years used to calculate the baselines. The baselines do not adjust for changes in age or other demographics, and they do not account for changes in total population.
#'
#' The number of expected deaths are not adjusted for how non-Covid-19 deaths may change during the outbreak, which will take some time to figure out. As countries impose control measures, deaths from causes like road accidents and homicides may decline. And people who die from Covid-19 cannot die later from other causes, which may reduce other causes of death. Both of these factors, if they play a role, would lead these baselines to understate, rather than overstate, the number of excess deaths.
#' @author Kieran Healy
#' @source The New York Times \url{https://github.com/nytimes/covid-19-data/tree/master/excess-deaths}.
#' @references For further details on these data see \url{https://github.com/nytimes/covid-19-data/tree/master/excess-deaths}
"nytexcess"

#' @title CDC Provisional death counts by week
#' @description Provisional Death Counts for Coronavirus Disease (COVID-19)
#' @format A data frame with `r fmt_nr(cdc_deaths_by_week)` rows and `r fmt_nc(cdc_deaths_by_week)` variables:
#' \describe{
#'   \item{\code{data_as_of}}{date When the data were most recently recorded}
#'   \item{\code{start_week}}{date Start week}
#'   \item{\code{end_week}}{double End week}
#'   \item{\code{covid_deaths}}{integer COVID deaths}
#'   \item{\code{total_deaths}}{integer Total deaths}
#'   \item{\code{percent_expected_deaths}}{double COLUMN_DESCRIPTION}
#'   \item{\code{pneumonia_deaths}}{integer COLUMN_DESCRIPTION}
#'   \item{\code{pneumonia_and_covid_deaths}}{integer COLUMN_DESCRIPTION}
#'   \item{\code{all_influenza_deaths_j09_j11}}{integer COLUMN_DESCRIPTION}
#'   \item{\code{pneumonia_influenza_and_covid_19_deaths}}{integer COLUMN_DESCRIPTION}
#'}
#' @details
#' ```{r, results = "asis", echo = FALSE}
#' skimr::skim(cdc_deaths_by_week)
#' ```
#'
#' The U.S. Centers for Disease Control provides weekly
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
#' @format A data frame with `r fmt_nr(cdc_deaths_by_age)` rows and `r fmt_nc(cdc_deaths_by_age)` variables:
#' \describe{
#'   \item{\code{data_as_of}}{date When the data were most recently recorded}
#'   \item{\code{age_group}}{character Age range}
#'   \item{\code{start_week}}{date Start week}
#'   \item{\code{end_week}}{date End week}
#'   \item{\code{covid_deaths}}{integer COLUMN_DESCRIPTION}
#'   \item{\code{total_deaths}}{integer COLUMN_DESCRIPTION}
#'   \item{\code{percent_expected_deaths}}{double COLUMN_DESCRIPTION}
#'   \item{\code{pneumonia_deaths}}{integer COLUMN_DESCRIPTION}
#'   \item{\code{pneumonia_and_covid_deaths}}{integer COLUMN_DESCRIPTION}
#'   \item{\code{all_influenza_deaths_j09_j11}}{integer COLUMN_DESCRIPTION}
#'}
#' @details
#' ```{r, results = "asis", echo = FALSE}
#' skimr::skim(cdc_deaths_by_age)
#' ```
#'
#' The U.S. Centers for Disease Control provides weekly
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
#' @format A data frame with `r fmt_nr(cdc_deaths_by_sex)` rows and `r fmt_nc(cdc_deaths_by_sex)` variables:
#' \describe{
#'   \item{\code{data_as_of}}{date Date most recently updated}
#'   \item{\code{sex}}{character Sex}
#'   \item{\code{start_week}}{date Beginning week}
#'   \item{\code{end_week}}{date Ending week}
#'   \item{\code{covid_deaths}}{integer COVID deaths}
#'   \item{\code{total_deaths}}{integer Total deaths}
#'   \item{\code{percent_expected_deaths}}{double COLUMN_DESCRIPTION}
#'   \item{\code{pneumonia_deaths}}{integer COLUMN_DESCRIPTION}
#'   \item{\code{pneumonia_and_covid_deaths}}{integer COLUMN_DESCRIPTION}
#'   \item{\code{all_influenza_deaths_j09_j11}}{integer COLUMN_DESCRIPTION}
#'}
#' @details
#' ```{r, results = "asis", echo = FALSE}
#' skimr::skim(cdc_deaths_by_sex)
#' ```
#'
#' The U.S. Centers for Disease Control provides weekly
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
#' @format A data frame with `r fmt_nr(cdc_deaths_by_state)` rows and `r fmt_nc(cdc_deaths_by_state)` variables:
#' \describe{
#'   \item{\code{data_as_of}}{date Date most recently updated}
#'   \item{\code{state}}{character State name}
#'   \item{\code{start_week}}{date Start week}
#'   \item{\code{end_week}}{double End week}
#'   \item{\code{covid_deaths}}{integer COVID Deaths}
#'   \item{\code{total_deaths}}{integer Total deaths}
#'   \item{\code{percent_expected_deaths}}{double COLUMN_DESCRIPTION}
#'   \item{\code{pneumonia_deaths}}{integer COLUMN_DESCRIPTION}
#'   \item{\code{pneumonia_and_covid_deaths}}{integer COLUMN_DESCRIPTION}
#'   \item{\code{all_influenza_deaths_j09_j11}}{integer COLUMN_DESCRIPTION}}
#' @details
#' ```{r, results = "asis", echo = FALSE}
#' skimr::skim(cdc_deaths_by_state)
#' ```
#'
#' The U.S. Centers for Disease Control provides weekly
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
#' @format A data frame with `r fmt_nr(cdc_catchments)` rows and `r fmt_nc(cdc_catchments)` variables:
#' \describe{
#' \item{\code{name}}{character Network name}
#' \item{\code{area}}{character Area}
#' }
#' @details
#' ```{r, results = "asis", echo = FALSE}
#' skimr::skim(cdc_catchments)
#' ```
#'
#' The Coronavirus Disease 2019 (COVID-19)-Associated Hospitalization Surveillance Network (COVID-NET) conducts population-based surveillance for laboratory-confirmed COVID-19-associated hospitalizations in children (persons younger than 18 years) and adults. The current network covers nearly 100 counties in the 10 Emerging Infections Program (EIP) states (CA, CO, CT, GA, MD, MN, NM, NY, OR, and TN) and four additional states through the Influenza Hospitalization Surveillance Project (IA, MI, OH, and UT). The network represents approximately 10% of US population (~32 million people). Cases are identified by reviewing hospital, laboratory, and admission databases and infection control logs for patients hospitalized with a documented positive SARS-CoV-2 test. Data gathered are used to estimate age-specific hospitalization rates on a weekly basis and describe characteristics of persons hospitalized with COVID-19. Laboratory confirmation is dependent on clinician-ordered SARS-CoV-2 testing. Therefore, the unadjusted rates provided are likely to be underestimated as COVID-19-associated hospitalizations can be missed due to test availability and provider or facility testing practices. COVID-NET hospitalization data are preliminary and subject to change as more data become available. All incidence rates are unadjusted. Please use the following citation when referencing these data: “COVID-NET: COVID-19-Associated Hospitalization Surveillance Network, Centers for Disease Control and Prevention. WEBSITE. Accessed on DATE”.
#'
#' `r knitr::kable(cdc_catchments)`
#'
#' @source Courtesy of Bob Rudis's cdccovidview package
#' @references <https://www.cdc.gov/coronavirus/2019-ncov/covid-data/covidview/index.html>
#' @author Kieran Healy
"cdc_catchments"

#' @title NSSP National COVID-related ER Visits
#' @description National Syndromic Surveillance Program (NSSP):
#' Emergency Department Visits and Percentage of Visits for COVID-19-Like Illness (CLI) or Influenza-like Illness (ILI)
#' @format A data frame with `r fmt_nr(nssp_covid_er_nat)` rows and `r fmt_nc(nssp_covid_er_nat)` variables:
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
#' @details
#' ```{r, results = "asis", echo = FALSE}
#' skimr::skim(nssp_covid_er_nat)
#' ```
#'
#' The U.S. Centers for Disease Control provides weekly
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
#' @format A tibble with `r fmt_nr(nssp_covid_er_reg)` rows and `r fmt_nc(nssp_covid_er_reg)` variables:
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
#' @details
#' ```{r, results = "asis", echo = FALSE}
#' skimr::skim(nssp_covid_er_reg)
#' ```
#'
#' The U.S. Centers for Disease Control provides weekly
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


#' @title Short Term Mortality Fluctuations (STMF) data series
#' @description Human Mortality Database (HMD) series of weekly death counts across countries.
#' @format A tibble with `r fmt_nr(stmf)` rows and `r fmt_nc(stmf)` variables:
#' \describe{
#'   \item{\code{country_code}}{Mortality database country code}
#'   \item{\code{cname}}{character Country name}
#'   \item{\code{iso2}}{character ISO2 country code}
#'   \item{\code{iso3}}{character ISO3 country code}
#'   \item{\code{year}}{double Year}
#'   \item{\code{week}}{double Week number. Each year in the STMF refers to 52 weeks, each week has 7 days. In some cases, the first week of a year may include several days from the previous year or the last week of a year may include days (and, respectively, deaths) of the next year. In particular, it means that a statistical year in the STMF is equal to the statistical year in annual country-specific statistics.}
#'   \item{\code{sex}}{character Sex. m = Males. f = Females. b = Both combined.}
#'   \item{\code{split}}{double Indicates if data were split from aggregated age groups (0 if the original data has necessary detailed age scale). For example, if the original age scale was 0-4, 5-29, 30-65, 65+, then split will be equal to 1}
#'   \item{\code{split_sex}}{double Indicates if the original data are available by sex (0) or data are interpolated (1)}
#'   \item{\code{forecast}}{double Equals 1 for all years where forecasted population exposures were used to calculate weekly death rates.}
#'   \item{\code{approx_date}}{double Approximate date (derived from the `year` and `week` number).}
#'   \item{\code{age_group}}{character Age group for death counts and rates}
#'   \item{\code{death_count}}{double Weekly death count. This number need not be an integer, because the age categories may be aggregated or split across the source national data.}
#'   \item{\code{death_rate}}{double Weekly death rate.}
#'   \item{\code{deaths_total}}{double Count of deaths for all ages combined.}
#'   \item{\code{rate_total}}{double Crude death rate.}
#'
#'}
#' @details For further details on the construction of this dataset see the
#'   codebook at \url{https://www.mortality.org/Public/STMF_DOC/STMFNote.pdf}.
#'   For the original input data files in standardized form, see
#'   \url{https://www.mortality.org/Public/STMF/Inputs/STMFinput.zip}.
#'
#' Countries and years covered in the dataset:
#'
#' ```{r, echo = FALSE}
#' knitr::kable(stmf_country_years(stmf))
#' ```
#'
#' Variables
#' ```{r, results = "asis", echo = FALSE}
#' skimr::skim(stmf)
#' ```
#'
#' @author Kieran Healy
#' @source Human Mortality Database, \url{http://mortality.org}
#' @references "Short-term Mortality Fluctuations Dataseries" n.d., \url{https://www.mortality.org/Public/STMF_DOC/STMFNote.pdf}
"stmf"

## Apple Mobility Data
#' @title Apple Mobility Data
#' @description Data from Apple Maps on relative changes in mobility in various cities and countries.
#' @format A data frame with `r fmt_nr(apple_mobility)` rows and `r fmt_nc(apple_mobility)` variables:
#' \describe{
#'   \item{\code{geo_type}}{character Type geographical unit. Values: city or country/region}
#'   \item{\code{region}}{character Name of geographical unit.}
#'   \item{\code{transportation_type}}{character Mode of transport. Values: Driving, Transit, or Walking}
#'   \item{\code{alternative_name}}{character Name of `region` in local language}
#'   \item{\code{sub_region}}{character Subregion}
#'   \item{\code{country}}{character Country name (not provided for all countries)}
#'   \item{\code{date}}{double Date in yyyy-mm-dddd format}
#'   \item{\code{score}}{double Activity score. Indexed to 100 on the first date of observation for a given mode of transport.}
#'}
#' @details
#' ```{r, results = "asis", echo = FALSE}
#' skimr::skim(apple_mobility)
#' ```
#'
#' Data made available by Apple, Inc. at \url{https://www.apple.com/covid19/mobility}, showing relative volume of directions requests per country/region or city compared to a baseline volume on January 13th, 2020. Apple defines the day as midnight-to-midnight, Pacific time. Cities represent usage in greater metropolitan areas and are stably defined during this period. In many countries/regions and cities, relative volume has increased since January 13th, consistent with normal, seasonal usage of Apple Maps. Day of week effects are important to normalize as you use this data. Data that is sent from users’ devices to the Apple Maps service is associated with random, rotating identifiers so Apple does not have a profile of individual movements and searches. Apple Maps has no demographic information about its users, and so cannot make any statements about the representativeness of its usage against the overall population.
#' @author Kieran Healy
#' @source https://www.apple.com/covid19/mobility
#' @references See https://www.apple.com/covid19/mobility for detailed terms of use.
"apple_mobility"


#' @title State population estimates for US States
#' @description Population estimates for US States as of July 1st 2018
#' @format A tibble with `r fmt_nr(uspop)` rows and `r fmt_nc(uspop)` variables:
#' \describe{
#'   \item{\code{state}}{character State Name}
#'   \item{\code{state_abbr}}{character State Abbreviation}
#'   \item{\code{statefips}}{character 2-digit FIPS code}
#'   \item{\code{region_name}}{character Census region}
#'   \item{\code{division_name}}{character Census Division}
#'   \item{\code{sex_id}}{character Sex id}
#'   \item{\code{sex}}{character Sex label}
#'   \item{\code{hisp_id}}{character Ethnicity: Hispanic id}
#'   \item{\code{hisp_label}}{character Hispanic label}
#'   \item{\code{fips}}{character Full FIPS code}
#'   \item{\code{pop}}{double Total population}
#'   \item{\code{white}}{double Race alone: White}
#'   \item{\code{black}}{double Race alone: Black or African-American}
#'   \item{\code{amind}}{double Race alone: American Indian and Alaska Native}
#'   \item{\code{asian}}{double Race alone: Asian}
#'   \item{\code{nhopi}}{double Race alone: Native Hawaiian and Other Pacific Islander}
#'   \item{\code{tom}}{double Race alone: Two or more races}
#'}
#' @details
#' ```{r, results = "asis", echo = FALSE}
#' skimr::skim(uspop)
#' ```
#'
#' U.S. Census estimates. Be aware of the US Census classifications of Race and Ethnicity. For the estimated total population for each State, jointly filter on  `totsex` in `sex_id` and `tothisp` in `hisp_id`  and then select `pop`.
#' @author Kieran Healy
#' @source https://www.census.gov/data/datasets/time-series/demo/popest/2010s-state-detail.html
#' @references \url{https://www2.census.gov/programs-surveys/popest/tables/2010-2018/state/asrh/PEPSR6H.pdf}
"uspop"

#' @title Provisional COVID-19 Death Counts by Sex, Age, and State
#' @description Deaths involving coronavirus disease 2019 (COVID-19), pneumonia, and influenza reported to NCHS by sex and age group and state.
#' @format A tibble with `r fmt_nr(nchs_sas)` rows and `r fmt_nc(nchs_sas)` variables:
#' \describe{
#'   \item{\code{data_as_of}}{date Date of data release}
#'   \item{\code{start_week}}{date First week-ending date of data period}
#'   \item{\code{end_week}}{date Last week-ending date of data period}
#'   \item{\code{state}}{character Jurisdiction of occurrence. One of: United States total, a US State, District of Columbia, *and New York City*, separate from New York state.}
#'   \item{\code{sex}}{character Sex}
#'   \item{\code{age_group}}{character Age group}
#'   \item{\code{covid_19_deaths}}{integer Deaths involving COVID-19 (ICD-code U07.1)}
#'   \item{\code{total_deaths}}{integer Deaths from all causes of death}
#'   \item{\code{pneumonia_deaths}}{integer Pneumonia Deaths (ICD-10 codes J12.0-J18.9)}
#'   \item{\code{pneumonia_and_covid_19_deaths}}{integer Deaths with Pneumonia and COVID-19 (ICD-10 codes J12.0-J18.9 and U07.1)}
#'   \item{\code{influenza_deaths}}{integer Influenza Deaths (ICD-10 codes J09-J11)}
#'   \item{\code{pneumonia_influenza_or_covid_19_deaths}}{integer Deaths with Pneumonia, Influenza, or COVID-19 (ICD-10 codes U07.1 or J09-J18.9)}
#'}
#' @details
#' ```{r, results = "asis", echo = FALSE}
#' skimr::skim(nchs_sas)
#' ```
#'
#' Number of deaths reported in this table are the total number of deaths received and coded as of the date of analysis,
#' and do not represent all deaths that occurred in that period. Data during this period are incomplete because of the lag in time
#' between when the death occurred and when the death certificate is completed, submitted to NCHS and processed for reporting purposes.
#' This delay can range from 1 week to 8 weeks or more. Missing values may indicate that a category has between 1 and 9 observed cases and have
#' been suppressed in accordance with NHCS confidentiality standards.
#' @author Kieran Healy
#' @source National Center for Health Statistics \url{https://data.cdc.gov/NCHS/Provisional-COVID-19-Death-Counts-by-Sex-Age-and-S/9bhg-hcku}
#' @references \url{https://data.cdc.gov/NCHS/Provisional-COVID-19-Death-Counts-by-Sex-Age-and-S/9bhg-hcku}
"nchs_sas"

#' @title Provisional Death Counts for Coronavirus Disease (COVID-19): Weekly State-Specific Data Updates
#' @description This report provides a weekly summary of deaths with coronavirus disease 2019 (COVID-19) by select geographic and demographic variables.
#' In this release, counts of deaths are provided by the race and Hispanic origin of the decedent.
#' @format A tibble with `r fmt_nr(nchs_wss)` rows and `r fmt_nc(nchs_wss)` variables:
#' \describe{
#'   \item{\code{data_as_of}}{date Date of analysis}
#'   \item{\code{start_date}}{date Start date of coverage}
#'   \item{\code{end_date}}{date End date of coverage}
#'   \item{\code{state}}{character Geographical unit. One of: the United States, a U.S. State, the District of Columbia, or New York City. New York state measures *do not* include New York City }
#'   \item{\code{group}}{character Population group}
#'   \item{\code{deaths}}{integer Count of deaths}
#'   \item{\code{dist_pct}}{double COLUMN_DESCRIPTION}
#'   \item{\code{uw_dist_pop_pct}}{double COLUMN_DESCRIPTION}
#'   \item{\code{wt_dist_pop_pct}}{double COLUMN_DESCRIPTION}
#'}
#' @details
#' ```{r, results = "asis", echo = FALSE}
#' skimr::skim(nchs_wss)
#' ```
#'
#' The percent of deaths reported in this table are the total number of represent all deaths received and coded as of the date of analysis
#' and do not represent all deaths that occurred in that period. Data are incomplete because of the lag in time between when the death occurred
#' and when the death certificate is completed, submitted to NCHS and processed for reporting purposes. *This delay can range from 1 week to 8 weeks or more*,
#' depending on the jurisdiction, age, and cause of death. Provisional counts reported here track approximately 1–2 weeks behind other published data sources
#' on the number of COVID-19 deaths in the U.S. COVID-19 deaths are defined as having confirmed or presumed COVID-19, and are coded to ICD–10 code U07.1.
#' Unweighted population percentages are based on the Single-Race Population Estimates from the U.S. Census Bureau, for the year 2018
#' (available from: https://wonder.cdc.gov/single-race-population.html). Weighted population percentages are computed by multiplying county-level population counts by
#' the count of COVID deaths for each county, summing to the state-level, and then estimating the percent of the population within each racial and ethnic group.
#' These weighted population distributions therefore more accurately reflect the geographic locations where COVID outbreaks are occurring.
#' Jurisdictions are included in this table if more than 100 deaths were received and processed by NCHS as of the data of analysis.
#'
#' Missing values may indicate that a category has between 1 and 9 observed cases and have been suppressed in accordance with NHCS confidentiality standards.
#' @author Kieran Healy
#' @source National Center for Health Statistics \url{https://data.cdc.gov/NCHS/Provisional-Death-Counts-for-Coronavirus-Disease-C/pj7m-y5uh}
"nchs_wss"

#' @title Weekly Counts of Deaths by State and Select Causes 2014-2020
#' @description Final counts of deaths by the week the deaths occurred, by state of occurrence, and by select causes of death for 2014-2018, and Provisional counts of deaths by the week the deaths occurred, by state of occurrence, and by select underlying causes of death for 2019-2020. The dataset also includes weekly provisional counts of death for COVID-19, coded to ICD-10 code U07.1 as an underlying or multiple cause of death.
#' @format A data frame with `r fmt_nr(nchs_wdc)` rows and `r fmt_nc(nchs_wdc)` variables:
#' \describe{
#'   \item{\code{jurisdiction}}{character Jurisdiction of Occurrence}
#'   \item{\code{year}}{double MMWR Year}
#'   \item{\code{week}}{double MMWR Week}
#'   \item{\code{week_ending_date}}{double MMWR Week ending date}
#'   \item{\code{cause_detailed}}{character Cause with ICD Codes}
#'   \item{\code{n}}{double Count of deaths}
#'   \item{\code{cause}}{character Cause of death}
#'}
#' @details For 2014-2018, death counts in this dataset were derived from the National Vital Statistics System database that provides the most timely access to the data. Therefore, counts may differ slightly from final data due to differences in processing, recoding, and imputation. For 2019-2020, the dataset also includes weekly provisional counts of death for COVID-19, coded to ICD-10 code U07.1 as an underlying or multiple cause of death.
#' Number of deaths reported in this table are the total number of deaths received and coded as of the date of analysis, and do not represent all deaths that occurred in that period. Data for 2019 and 2020 are provisional and may be incomplete because of the lag in time between when the death occurred and when the death certificate is completed, submitted to NCHS and processed for reporting purposes. Causes of death included in this dataset are tabulated by underlying cause of death ICD-10 codes. COVID-19 deaths by underlying cause and multiple cause of death are also included.
#' @author Kieran Healy
#' @source 2014-2018: \url{https://data.cdc.gov/NCHS/Weekly-Counts-of-Deaths-by-State-and-Select-Causes/3yf8-kanr}. 2019-2020: \url{https://data.cdc.gov/NCHS/Weekly-Counts-of-Deaths-by-State-and-Select-Causes/muzy-jte6}
#' @references
"nchs_wdc"
