## code to prepare covdata datasets

library(tidyverse)
library(lubridate)
library(here)
library(janitor)
library(socviz)
library(ggrepel)
library(paletteer)

## Check for data/ dir in data-raw
ifelse(!dir.exists(here("data-raw/data")),
       dir.create(file.path("data-raw/data")),
       FALSE)

### --------------------------------------------------------------------------------------
### Functions to get data
### --------------------------------------------------------------------------------------

### --------------------------------------------------------------------------------------
### ECDC Data
### --------------------------------------------------------------------------------------

## Download today's CSV file, saving it to data/ and also read it in
get_ecdc_csv <- function(url = "https://opendata.ecdc.europa.eu/covid19/casedistribution/csv",
                         date = lubridate::today(),
                         writedate = lubridate::today(),
                         fname = "ecdc-cumulative-",
                         ext = "csv",
                         dest = "data-raw/data",
                         save_file = c("y", "n")) {

  target <- url
  message("target: ", target)
  save_file <- match.arg(save_file)

  destination <- fs::path(here::here("data-raw/data"), paste0(fname, writedate), ext = ext)

  tf <- tempfile(fileext = ext)
  curl::curl_download(target, tf)

  switch(save_file,
    y = fs::file_copy(tf, destination),
    n = NULL)

  janitor::clean_names(readr::read_csv(tf))

}

### --------------------------------------------------------------------------------------
### COVID Tracking Project Data
### --------------------------------------------------------------------------------------

## Get Daily COVID Tracking Project Data
## form is https://covidtracking.com/api/us/daily.csv
get_uscovid_data <- function(url = "https://covidtracking.com/api/",
                             unit = c("states", "us"),
                             fname = "-",
                             date = lubridate::today(),
                             ext = "csv",
                             dest = "data-raw/data",
                             save_file = c("y", "n")) {
  unit <- match.arg(unit)
  save_file = match.arg(save_file)
  target <-  paste0(url, unit, "/", "daily.", ext)
  message("target: ", target)

  destination <- fs::path(here::here("data-raw/data"),
                          paste0(unit, "_daily_", date), ext = ext)

  tf <- tempfile(fileext = ext)
  curl::curl_download(target, tf)

  switch(save_file,
         y = fs::file_copy(tf, destination),
         n = NULL)

  janitor::clean_names(read_csv(tf))
}

## This URL will yield a file named "RACE Data Entry - CRDT.csv"
get_uscovid_race_data <- function(url = "https://docs.google.com/spreadsheets/d/e/2PACX-1vR_xmYt4ACPDZCDJcY12kCiMiH0ODyx3E1ZvgOHB8ae1tRcjXbs_yWBOA4j4uoCEADVfC1PS2jYO68B/pub?gid=43720681&single=true&output=csv",
                             date = lubridate::today(),
                             ext = "csv",
                             dest = "data-raw/data",
                             save_file = c("y", "n")) {
  save_file <- match.arg(save_file)
  target <-  url
  message("target: ", target)

  destination <- fs::path(here::here("data-raw/data"),
                          paste0("covus_crt_daily_", date), ext = ext)
  message("destination: ", destination)

  tf <- tempfile(fileext = ext)
  curl::curl_download(target, tf)

  switch(save_file,
         y = fs::file_copy(tf, destination),
         n = NULL)

  janitor::clean_names(read_csv(tf))
}




### --------------------------------------------------------------------------------------
### Google mobility data
### --------------------------------------------------------------------------------------

## Google
get_google_data <- function(url = "https://www.gstatic.com/covid19/mobility/",
                             fname = "Global_Mobility_Report",
                             date = lubridate::today(),
                             ext = "csv",
                             dest = "data-raw/data",
                             save_file = c("n", "y")) {

  save_file <- match.arg(save_file)

  target <-  paste0(url, fname, ".", ext)
  message("target: ", target)

  destination <- fs::path(here::here("data-raw/data"),
                          paste0(fname, "_", date), ext = ext)

  tf <- tempfile(fileext = ext)
  curl::curl_download(target, tf)

  switch(save_file,
         y = fs::file_copy(tf, destination),
         n = NULL)

  ## Need a colspec for the Google data because it's so large
  ## read_csv's guesses fail for some columns.
  gm_spec <- cols(country_region_code = col_character(),
                  country_region = col_character(),
                  sub_region_1 = col_character(),
                  sub_region_2 = col_character(),
                  iso_3166_2_code = col_character(),
                  census_fips_code = col_character(),
                  date = col_date(),
                  retail_and_recreation_percent_change_from_baseline = col_integer(),
                  grocery_and_pharmacy_percent_change_from_baseline = col_integer(),
                  parks_percent_change_from_baseline = col_integer(),
                  transit_stations_percent_change_from_baseline = col_integer(),
                  workplaces_percent_change_from_baseline = col_integer(),
                  residential_percent_change_from_baseline = col_integer())


  janitor::clean_names(read_csv(tf, col_types = gm_spec))
}

###  --------------------------------------------------------------------------------------
###  mortality.org Short Term Mortality Fluctuations data
###  --------------------------------------------------------------------------------------

get_stmf <- function(url = "https://www.mortality.org/Public/STMF/Outputs",
                     fname = "stmf",
                     date = lubridate::today(),
                     ext = "csv",
                     dest = "data-raw/data",
                     save_file = c("n", "y"),
                     ...) {
  save_file <- match.arg(save_file)
  target <-  fs::path(url, fname, ext = ext)
  message("target: ", target)

  destination <- fs::path(here::here("data-raw/data"),
                          paste0(fname, "_", date), ext = ext)

  tf <- tempfile(fileext = ext)
  curl::curl_download(target, tf)

  switch(save_file,
         y = fs::file_copy(tf, destination),
         n = NULL)

  janitor::clean_names(read_csv(tf, ...))
}

### --------------------------------------------------------------------------------------
### NYT Data
### --------------------------------------------------------------------------------------

## Get NYT data from their repo
## Generic NYT get
get_nyt_data <- function(url = "https://github.com/nytimes/covid-19-data/raw/master/",
                        fname = "us-counties",
                        date = lubridate::today(),
                        ext = "csv",
                        dest = "data-raw/data",
                        save_file = c("n", "y"),
                        ...) {

  save_file <- match.arg(save_file)
  target <-  fs::path(url, fname, ext = ext)
  message("target: ", target)

  destination <- fs::path(here::here("data-raw/data"),
                          paste0(fname, "_", date), ext = ext)

  tf <- tempfile(fileext = ext)
  curl::curl_download(target, tf)

  switch(save_file,
         y = fs::file_copy(tf, destination),
         n = NULL)

  janitor::clean_names(read_csv(tf, ...))

}


### --------------------------------------------------------------------------------------
### Apple Mobility Data
### --------------------------------------------------------------------------------------

## Get Apple data
## 1. Find today's URL
get_apple_target <- function(cdn_url = "https://covid19-static.cdn-apple.com",
                             json_file = "covid19-mobility-data/current/v3/index.json") {
  tf <- tempfile(fileext = ".json")
  curl::curl_download(paste0(cdn_url, "/", json_file), tf)
  json_data <- jsonlite::fromJSON(tf)
  paste0(cdn_url, json_data$basePath, json_data$regions$`en-us`$csvPath)
}

## 2. Get the data and return a tibble
get_apple_data <- function(url = get_apple_target(),
                             fname = "applemobilitytrends-",
                             date = stringr::str_extract(get_apple_target(), "\\d{4}-\\d{2}-\\d{2}"),
                             ext = "csv",
                             dest = "data-raw/data",
                             save_file = c("n", "y")) {

  save_file <- match.arg(save_file)
  message("target: ", url)

  destination <- fs::path(here::here("data-raw/data"),
                          paste0("apple_mobility", "_daily_", date), ext = ext)

  tf <- tempfile(fileext = ext)
  curl::curl_download(url, tf)

  ## We don't save the file by default
  switch(save_file,
         y = fs::file_copy(tf, destination),
         n = NULL)

  janitor::clean_names(readr::read_csv(tf))
}

### --------------------------------------------------------------------------------------
### CoronaNet Data
### --------------------------------------------------------------------------------------

## See https://github.com/saudiwin/corona_tscs
## and https://osf.io/preprints/socarxiv/jp4wk

# https://raw.githubusercontent.com/saudiwin/corona_tscs/master/data/CoronaNet/coronanet_release.csv
get_corona_tscs <- function(url = "https://raw.githubusercontent.com/saudiwin/corona_tscs/master/data/CoronaNet",
                            fname = "coronanet_release",
                            date = lubridate::today(),
                            ext = "csv",
                            dest = "data-raw/data",
                            save_file = c("n", "y")) {

  save_file <- match.arg(save_file)
  target <-  paste0(url, "/", fname, ".", ext)
  message("target: ", target)

  destination <- fs::path(here::here("data-raw/data"),
                          paste0("", date), ext = ext)

  tf <- tempfile(fileext = ext)
  curl::curl_download(target, tf)

  switch(save_file,
         y = fs::file_copy(tf, destination),
         n = NULL)

  cn_spec <- cols(
    record_id = col_character(),
    policy_id = col_character(),
    recorded_date = col_datetime(),
    date_announced = col_datetime(),
    date_start = col_date(),
    date_end = col_date(),
    entry_type = col_character(),
    event_description = col_character(),
    domestic_policy = col_integer(),
    type = col_character(),
    type_sub_cat = col_character(),
    type_text = col_integer(),
    index_high_est = col_double(),
    index_med_est = col_double(),
    index_low_est  = col_double(),
    index_country_rank = col_double(),
    country = col_character(),
    init_country_level = col_character(),
    province = col_character(),
    source_corr_type = col_character(),
    target_country = col_character(),
    target_geog_level = col_character(),
    target_region = col_character(),
    target_province = col_character(),
    target_city = col_character(),
    target_other = col_character(),
    target_other = col_logical(),
    target_direction = col_character(),
    travel_mechanism = col_character(),
    compliance = col_character(),
    enforcer = col_character(),
    link = col_character()
  )


  janitor::clean_names(read_csv(tf, col_types = cn_spec))

}

### --------------------------------------------------------------------------------------
### CDC data custom function (cdccovidview is out of date)
### --------------------------------------------------------------------------------------

my_pdc <-  function ()
{

  res <- jsonlite::fromJSON("https://data.cdc.gov/resource/hc4f-j6nb.json")
  res <- as_tibble(res)
  res$covid_deaths <- cdccovidview:::clean_int(res$covid_deaths)
  res$total_deaths <- cdccovidview:::clean_int(res$total_deaths)
  res$percent_expected_deaths <- cdccovidview:::clean_num(res$percent_expected_deaths)
  res$pneumonia_deaths <- cdccovidview:::clean_int(res$pneumonia_deaths)
  res$pneumonia_and_covid_deaths <- cdccovidview:::clean_int(res$pneumonia_and_covid_deaths)
  res$all_influenza_deaths_j09_j11 <-cdccovidview::: clean_int(res$all_influenza_deaths_j09_j11)
  res$pneumonia_influenza_and_covid_19_deaths <- cdccovidview:::clean_int(res$pneumonia_influenza_and_covid_19_deaths)

  by_week <- res[res$group == "By week", ]
  by_age <- res[res$group == "By age", ]
  by_state <- res[res$group == "By state", ]
  by_sex <- res[res$group == "By sex", ]

  by_week <- by_week[!grepl("total", tolower(by_week$indicator)), ]
  by_week$group <- NULL
  by_week$indicator <- NULL
  by_week$footnote <- NULL
  by_week$state <- NULL
  by_week$start_week <- as.Date(by_week$start_week)
  by_week$end_week <- as.Date(by_week$end_week)
  by_week$data_as_of <- as.Date(by_week$data_as_of)
  colnames(by_week) <- c("data_as_of", "start_week", "end_week", "covid_deaths", "total_deaths",
                         "percent_expected_deaths", "pneumonia_deaths", "pneumonia_and_covid_deaths",
                         "all_influenza_deaths_j09_j11", "pneumonia_influenza_and_covid_19_deaths",
                         "pneumonia_influenza_and_covid_deaths")

  by_age$group <- NULL
  by_age$footnote <- NULL
  by_age$state <- NULL
  by_age$pneumonia_influenza_and_covid_19_deaths <- NULL

  colnames(by_age) <- c("data_as_of", "age_group", "start_week", "end_week", "covid_deaths", "total_deaths",
                        "percent_expected_deaths", "pneumonia_deaths", "pneumonia_and_covid_deaths",
                        "all_influenza_deaths_j09_j11",
                        "pneumonia_influenza_and_covid_deaths")
  by_age$age_group <- sub("&ndash;", "-", by_age$age_group,
                          fixed = TRUE)
  by_age$age_group <- sub("yea.*", "yr", by_age$age_group)
  by_age$data_as_of <- as.Date(by_age$data_as_of)
  by_age$start_week <- as.Date(by_age$start_week)
  by_age$end_week <- as.Date(by_age$end_week)


  by_state$group <- NULL
  by_state$footnote <- NULL
  by_state$indicator <- NULL
  by_state$pneumonia_influenza_and_covid_19_deaths <- NULL

  by_state$data_as_of <- as.Date(by_state$data_as_of)
  by_state$start_week <- as.Date(by_state$start_week)
  by_state$end_week <- as.Date(by_state$end_week)
  colnames(by_state) <- c("data_as_of", "state", "start_week", "end_week", "covid_deaths", "total_deaths",
                          "percent_expected_deaths", "pneumonia_deaths", "pneumonia_and_covid_deaths",
                          "all_influenza_deaths_j09_j11",
                          "pneumonia_influenza_and_covid_deaths")
  by_state <- by_state[by_state$state != "United States", ]


  by_sex$group <- NULL
  by_sex$footnote <- NULL
  by_sex$state <- NULL
  by_sex$pneumonia_influenza_and_covid_19_deaths <- NULL

  by_sex$data_as_of <- as.Date(by_sex$data_as_of)
  by_sex$start_week <- as.Date(by_sex$start_week)
  by_sex$end_week <- as.Date(by_sex$end_week)


  colnames(by_sex) <- c("data_as_of", "sex", "start_week", "end_week", "covid_deaths", "total_deaths",
                        "percent_expected_deaths", "pneumonia_deaths", "pneumonia_and_covid_deaths",
                        "all_influenza_deaths_j09_j11",
                        "pneumonia_influenza_and_covid_deaths")

  by_sex <- by_sex[!grepl("Total deaths", by_sex$sex), ]
  list(by_week = as_tibble(by_week), by_age = as_tibble(by_age),
       by_state = as_tibble(by_state), by_sex = as_tibble(by_sex))
}

### --------------------------------------------------------------------------------------
### NCHS data via the CDC
### --------------------------------------------------------------------------------------

nchs_tables <- tribble(
  ~name, ~sname, ~locator,
  "Death Counts by Sex, Age, and State", "SAS", "9bhg-hcku",
  "Weekly State Specific Updates", "WSS", "pj7m-y5uh",
  "COVID-19 Case Surveillance Public Use Data", "CSPUD", "vbim-akqf"
)

get_nchs_data <- function(url = "https://data.cdc.gov/api/views",
                             sname = c("SAS", "WSS", "CSPUD"),
                             fname = "-",
                             date = lubridate::today(),
                             ext = "csv",
                             dest = "data-raw/data",
                             save_file = c("y", "n"),
                          clean_names = c("y", "n")) {
  sname <- match.arg(sname)
  save_file <- match.arg(save_file)
  clean_names <- match.arg(clean_names)

  target <-  paste0(url, "/", as.character(nchs_tables[nchs_tables$sname == sname, "locator"]),
                    "/rows.csv?accessType=DOWNLOAD")
  message("target: ", target)

  destination <- fs::path(here::here("data-raw/data"),
                          paste0(sname, "_on_", date), ext = ext)

  tf <- tempfile(fileext = ext)
  curl::curl_download(target, tf)

  switch(save_file,
         y = fs::file_copy(tf, destination),
         n = NULL
         )

  switch(clean_names,
         y = janitor::clean_names(read_csv(tf)),
         n = read_csv(tf)
         )
}



### --------------------------------------------------------------------------------------
### Data munging functions
### --------------------------------------------------------------------------------------

## A useful function from Edward Visel, which does a thing
## with tibbles that in the past I've done variable-by-variable
## using match(), like an animal. The hardest part was
## figuring out that this operation is called a coalescing join
## https://alistaire.rbind.io/blog/coalescing-joins/
coalesce_join <- function(x, y,
                          by = NULL, suffix = c(".x", ".y"),
                          join = dplyr::full_join, ...) {
  joined <- join(x, y, by = by, suffix = suffix, ...)
  # names of desired output
  cols <- dplyr::union(names(x), names(y))

  to_coalesce <- names(joined)[!names(joined) %in% cols]
  suffix_used <- suffix[ifelse(endsWith(to_coalesce, suffix[1]), 1, 2)]
  # remove suffixes and deduplicate
  to_coalesce <- unique(substr(
    to_coalesce,
    1,
    nchar(to_coalesce) - nchar(suffix_used)
  ))

  coalesced <- purrr::map_dfc(to_coalesce, ~dplyr::coalesce(
    joined[[paste0(.x, suffix[1])]],
    joined[[paste0(.x, suffix[2])]]
  ))
  names(coalesced) <- to_coalesce

  dplyr::bind_cols(joined, coalesced)[cols]
}

### --------------------------------------------------------------------------------------
### ISO Country Codes
### --------------------------------------------------------------------------------------

## ----iso-country-codes-------------------------------------------------------------------------------------------
## Country codes. The ECDC does not quite use standard codes for countries
## These are the iso2 and iso3 codes, plus some convenient groupings for
## possible use later
iso3_cnames <- read_csv("data-raw/data/countries_iso3.csv")
iso2_to_iso3 <- read_csv("data-raw/data/iso2_to_iso3.csv")

cname_table <- left_join(iso3_cnames, iso2_to_iso3)

cname_table

eu <- c("AUT", "BEL", "BGR", "HRV", "CYP", "CZE", "DNK", "EST", "FIN", "FRA",
        "DEU", "GRC", "HUN", "IRL", "ITA", "LVA", "LTU", "LUX", "MLT", "NLD",
        "POL", "PRT", "ROU", "SVK", "SVN", "ESP", "SWE", "GBR")

europe <- c("ALB", "AND", "AUT", "BLR", "BEL", "BIH", "BGR", "HRV", "CYP", "CZE",
            "DNK", "EST", "FRO", "FIN", "FRA", "DEU", "GIB", "GRC", "HUN", "ISL",
            "IRL", "ITA", "LVA", "LIE", "LTU", "LUX", "MKD", "MLT", "MDA", "MCO",
            "NLD", "NOR", "POL", "PRT", "ROU", "RUS", "SMR", "SRB", "SVK", "SVN",
            "ESP", "SWE", "CHE", "UKR", "GBR", "VAT", "RSB", "IMN", "MNE", "XKV",
            "GGY", "JEY")

north_america <- c("AIA", "ATG", "ABW", "BHS", "BRB", "BLZ", "BMU", "VGB", "CAN", "CYM",
                   "CRI", "CUB", "CUW", "DMA", "DOM", "SLV", "GRL", "GRD", "GLP", "GTM",
                   "HTI", "HND", "JAM", "MTQ", "MEX", "SPM", "MSR", "ANT", "KNA", "NIC",
                   "PAN", "PRI", "KNA", "LCA", "SPM", "VCT", "TTO", "TCA", "VIR", "USA",
                   "SXM", "BES")

south_america <- c("ARG", "BOL", "BRA", "CHL", "COL", "ECU", "FLK", "GUF", "GUY", "PRY",
                   "PER", "SUR", "URY", "VEN")


africa <- c("DZA", "AGO", "SHN", "BEN", "BWA", "BFA", "BDI", "CMR", "CPV", "CAF",
            "TCD", "COM", "COG", "DJI", "EGY", "GNQ", "ERI", "ETH", "GAB", "GMB",
            "GHA", "GNB", "GIN", "CIV", "KEN", "LSO", "LBR", "LBY", "MDG", "MWI",
            "MLI", "MRT", "MUS", "MYT", "MAR", "MOZ", "NAM", "NER", "NGA", "STP",
            "REU", "RWA", "STP", "SEN", "SYC", "SLE", "SOM", "ZAF", "SHN", "SDN",
            "SWZ", "TZA", "TGO", "TUN", "UGA", "COD", "ZMB", "TZA", "ZWE", "SSD",
            "COD", "ESH")

asia <- c("AFG", "ARM", "AZE", "BHR", "BGD", "BTN", "BRN", "KHM", "CHN", "CXR",
          "CCK", "IOT", "GEO", "HKG", "IND", "IDN", "IRN", "IRQ", "ISR", "JPN",
          "JOR", "KAZ", "PRK", "KOR", "KWT", "KGZ", "LAO", "LBN", "MAC", "MYS",
          "MDV", "MNG", "MMR", "NPL", "OMN", "PAK", "PHL", "QAT", "SAU", "SGP",
          "LKA", "SYR", "TWN", "TJK", "THA", "TUR", "TKM", "ARE", "UZB", "VNM",
          "YEM", "PSE")

oceania <- c("ASM", "AUS", "NZL", "COK", "FJI", "PYF", "GUM", "KIR", "MNP", "MHL",
             "FSM", "UMI", "NRU", "NCL", "NZL", "NIU", "NFK", "PLW", "PNG", "MNP",
             "SLB", "TKL", "TON", "TUV", "VUT", "UMI", "WLF", "WSM", "TLS")


continents <- tribble(
  ~iso3, ~continent,
  africa, "Africa",
  asia, "Asia",
  europe, "Europe",
  north_america, "North America",
  oceania, "Oceania",
  south_america, "South America"
) %>%
  unnest(cols = c("iso3"))

### --------------------------------------------------------------------------------------
### Get the data
### --------------------------------------------------------------------------------------

### --------------------------------------------------------------------------------------
### Get ECDC data
### --------------------------------------------------------------------------------------

covid_raw <- get_ecdc_csv(save = "n")

covid_raw

covid <- covid_raw %>%
  mutate(date = lubridate::dmy(date_rep),
         iso2 = geo_id)

## merge in the iso country names
covid <- left_join(covid, cname_table)

## A few ECDC country codes are non-iso, notably the UK
anti_join(covid, cname_table) %>%
  select(geo_id, countries_and_territories, iso2, iso3, cname) %>%
  distinct()

## A small crosswalk file that we'll coalesce into the missing values
## We need to specify the na explicity because the xwalk file has Namibia
## as a country -- i.e. country code = string literal "NA"
cname_xwalk <- read_csv("data-raw/data/ecdc_to_iso2_xwalk.csv",
                        na = "")

cname_xwalk

covid <- coalesce_join(covid, cname_xwalk,
                       by = "geo_id", join = dplyr::left_join)

## Take a look again
anti_join(covid, cname_table) %>%
  select(geo_id, countries_and_territories, iso2, iso3, cname) %>%
  distinct()

covnat <- covid %>%
  select(date, cname, iso3, cases, deaths, pop_data2019) %>%
  rename(pop = pop_data2019) %>%
  drop_na(iso3) %>%
  group_by(iso3) %>%
  arrange(date) %>%
  mutate(cu_cases = cumsum(cases),
         cu_deaths = cumsum(deaths))

covnat ## Data object

countries <- covnat %>%
  distinct(cname, iso3) %>%
  left_join(cname_table) %>%
  left_join(continents)



### --------------------------------------------------------------------------------------
### Get US Data from the COVID Tracking Project
### --------------------------------------------------------------------------------------

## US state data
cov_us_raw <- get_uscovid_data(url = "https://covidtracking.com/api/v1/", save_file = "n")

## Drop deprecated measures and unneeded variables
drop_cols <- c("check_time_et", "commercial_score", "date_checked",
               "death_increase", "date_modified", "grade", "hash",
               "hospitalized", "hospitalized_increase", "last_update_et",
               "negative_increase", "negative_regular_score",
               "negative_score", "pos_neg", "positive_increase",
               "positive_score", "score", "total", "total_test_results",
               "total_test_results_increase")

covus <- cov_us_raw %>%
  mutate(date = lubridate::ymd(date)) %>%
  select(!all_of(drop_cols)) %>%
  select(date, state, fips, data_quality_grade, everything()) %>%
  pivot_longer(positive:death_probable,
               names_to = "measure", values_to = "count")

covus_measure_labels <- tribble(
  ~measure, ~measure_label,
  "death", "Deaths",
  "death_confirmed", "Deaths Confirmed",
  "death_probable", "Deaths Probable",
  "hospitalized_cumulative", "Cumulative Hospitalized",
  "hospitalized_currently",   "Currently Hospitalized",
  "in_icu_cumulative",        "Cumulative in ICU",
  "in_icu_currently",         "Currently in ICU",
  "negative", "Negative Tests",
  "negative_tests_viral", "Total number of negative PCR tests",
  "on_ventilator_cumulative", "Cumulative on Ventilator",
  "on_ventilator_currently",  "Currently on Ventilator",
  "pending",                  "Pending Tests",
  "positive",                 "Positive Tests",
  "positive_cases_viral", "Total number of positive cases measured with PCR tests",
  "positive_tests_viral", "Total number of positive PCR tests",
  "recovered", "Recovered",
  "total_tests_viral", "Total number of PCR tests performed"
)

covus <- covus %>%
  left_join(covus_measure_labels)


covus ## Data object


### COVID Tracking Project Race Data
covus_race_raw <- get_uscovid_race_data(save = "n")

covus_raw_date <-  "%Y%m%d"

covus_race_all <- covus_race_raw %>%
  mutate(across(where(is_double), as.character)) %>%
  type_convert(col_types = cols(date = col_date(format = covus_raw_date),
  state = col_character(),
  cases_total = col_integer(),
  cases_white = col_integer(),
  cases_black = col_integer(),
  cases_latin_x = col_integer(),
  cases_asian = col_integer(),
  cases_aian = col_integer(),
  cases_nhpi = col_integer(),
  cases_multiracial = col_integer(),
  cases_other = col_integer(),
  cases_unknown = col_integer(),
  cases_ethnicity_hispanic = col_integer(),
  cases_ethnicity_non_hispanic = col_integer(),
  cases_ethnicity_unknown = col_integer(),
  deaths_total = col_integer(),
  deaths_white = col_integer(),
  deaths_black = col_integer(),
  deaths_latin_x = col_integer(),
  deaths_asian = col_integer(),
  deaths_aian = col_integer(),
  deaths_nhpi = col_integer(),
  deaths_multiracial = col_integer(),
  deaths_other = col_integer(),
  deaths_unknown = col_integer(),
  deaths_ethnicity_hispanic = col_integer(),
  deaths_ethnicity_non_hispanic = col_integer(),
  deaths_ethnicity_unknown = col_integer())) %>%
  rename(cases_latinx = cases_latin_x,
         deaths_latinx = deaths_latin_x)


covus_race_tots <- covus_race_all %>%
  select(date, state, cases_total, deaths_total)

covus_ethnicity <- covus_race_all %>%
  select(date, state, contains("_ethnicity_") & !contains("total")) %>%
  pivot_longer(
    cols = cases_ethnicity_hispanic:deaths_ethnicity_unknown,
    names_to = c("measure", "group"),
    names_pattern = "(cases|deaths)_ethnicity_(.*)",
    values_to = "count"
  ) %>%
  pivot_wider(
    names_from = measure,
    values_from = count
  )

covus_race <- covus_race_all %>%
  select(date, state, !contains("_ethnicity_") & !contains("total")) %>%
  pivot_longer(
    cols = cases_white:deaths_unknown,
    names_to = c("measure", "group"),
    names_pattern = "(cases|deaths)_(.*)",
    values_to = "count"
  ) %>%
  pivot_wider(
    names_from = measure,
    values_from = count
  )


covus_race_tots

covus_ethnicity %>%
  group_by(state) %>%
  summarize(across(where(is.integer), sum, na.rm = TRUE))

covus_race %>%
  group_by(state) %>%
  summarize(across(where(is.integer), sum, na.rm = TRUE))


covus_ethnicity <- covus_ethnicity %>%
  mutate(group = recode(group, hispanic = "Hispanic",
                        non_hispanic = "Non-Hispanic",
                        unknown = "Unknown"))

covus_race  <- covus_race %>%
  mutate(group = recode(group, white = "White",
                        black = "Black", latinx = "Latino",
                        asian = "Asian", aian = "AI/AN",
                        multiracial = "Multiracial",
                        nhpi = "NH/PI", other = "Other",
                        unknown = "Unknown"))


### --------------------------------------------------------------------------------------
### NYT Data
### --------------------------------------------------------------------------------------

## NYT county data
nytcovcounty <- get_nyt_data(fname = "us-counties")

## NYT state data
nytcovstate <- get_nyt_data(fname = "us-states")

## NYT national (US only) data
nytcovus <- get_nyt_data(fname = "us")

## NYT excess deaths
nytexcess <- get_nyt_data(fname = "excess-deaths/deaths",
                          col_types = cols(
                            country = "c",
                            placename = "c",
                            frequency = "c",
                            start_date = "D",
                            end_date = "D",
                            year = "c", # sic
                            month = "i",
                            week = "i",
                            deaths = "i",
                            expected_deaths = "i",
                            excess_deaths = "i",
                            baseline = "c"))

### --------------------------------------------------------------------------------------
### CDC Data
### --------------------------------------------------------------------------------------

## Get CDC Surveillance Data
## Courtesy of Bob Rudis's cdccovidview package
cdc_hospitalizations <- cdccovidview::laboratory_confirmed_hospitalizations()

## cdc_death_counts <- cdccovidview::provisional_death_counts()
cdc_death_counts <- my_pdc()

cdc_deaths_by_week <- cdc_death_counts$by_week
cdc_deaths_by_age <- cdc_death_counts$by_age
cdc_deaths_by_sex <- cdc_death_counts$by_sex
cdc_deaths_by_state <- cdc_death_counts$by_state

cdc_catchments <- cdccovidview::surveillance_areas()

nssp_covid_er_nat <- cdccovidview::nssp_er_visits_national()
nssp_covid_er_reg <- cdccovidview::nssp_er_visits_regional()


## --------------------------------------------------------------------------------------
### CDC / National Center for Health Statistics
### --------------------------------------------------------------------------------------

## Get NCHS breakdowns by State, via the CDC
nchs_sas_raw <- get_nchs_data(sname = "SAS",
                          save_file = "n")

us_style <-  "%m/%d/%Y"

nchs_sas <- nchs_sas_raw %>%
  mutate(across(where(is_double), as.character)) %>%
  type_convert(col_types = cols(
    data_as_of = col_date(format = us_style),
    start_week = col_date(format = us_style),
    end_week = col_date(format = us_style),
    state = "c",
    sex = "c",
    age_group = "c",
    covid_19_deaths = "i",
    total_deaths = "i",
    pneumonia_deaths = "i",
    pneumonia_and_covid_19_deaths = "i",
    influenza_deaths = "i",
    pneumonia_influenza_or_covid_19_deaths = "i",
    footnote = "c"
  )) %>%
  select(-footnote) %>%
  mutate(age_group = stringr::str_to_sentence(age_group)) %>%
  filter(!stringr::str_detect(state, "Total"))

nchs_wss_raw <- get_nchs_data(sname = "WSS",
                              save_file = "n",
                              clean_names = "n")

nchs_wss <- nchs_wss_raw %>%
  select(-Footnote) %>%
  pivot_longer(`Non-Hispanic White`:`Other`,
               names_to = "group") %>%
  pivot_wider(names_from = Indicator) %>%
  janitor::clean_names() %>%
  rename(deaths = count_of_covid_19_deaths,
         dist_pct = distribution_of_covid_19_deaths_percent,
         uw_dist_pop_pct = unweighted_distribution_of_population_percent,
         wt_dist_pop_pct = weighted_distribution_of_population_percent) %>%
  mutate(state = stringr::str_replace(state, "<sup>5</sup>", ""))

nchs_cspud_raw <- get_nchs_data(sname = "CSPUD",
                                save_file = "n")

nchs_pud <- nchs_cspud_raw %>%
  mutate(current_status = recode(current_status,
                                 "Laboratory-confirmed case" = "Confirmed", "Probable Case" = "Probable"),
         age_group = stringr::str_replace(age_group, "Years", "yrs"),
         age_group = stringr::str_replace_all(age_group, " ", ""),
         race_and_ethnicity_combined = stringr::str_replace(race_and_ethnicity_combined,
                                                            "American Indian/Alaska Native",
                                                            "AI/AN"),
         race_and_ethnicity_combined = stringr::str_replace(race_and_ethnicity_combined,
                                                            "Native Hawaiian/Other Pacific Islander",
                                                            "NH/PI")) %>%
  rename(race_ethnicity = race_and_ethnicity_combined)

## --------------------------------------------------------------------------------------
### Apple and Google
### --------------------------------------------------------------------------------------

## Apple Mobility Data
apple_mobility <- get_apple_data() %>%
  pivot_longer(cols = starts_with("x"), names_to = "date", values_to = "index") %>%
  mutate(
    date = stringr::str_remove(date, "x"),
    date = stringr::str_replace_all(date, "_", "-"),
    date = as_date(date))

## Google Mobility Data

google_mobility <- get_google_data() %>%
  rename(iso3166_2 = iso_3166_2_code,
    retail = retail_and_recreation_percent_change_from_baseline,
         grocery = grocery_and_pharmacy_percent_change_from_baseline,
         parks = parks_percent_change_from_baseline,
         transit = transit_stations_percent_change_from_baseline,
         workplaces = workplaces_percent_change_from_baseline,
         residential = residential_percent_change_from_baseline) %>%
  pivot_longer(retail:residential, names_to = "type", values_to = "pct_diff")


### --------------------------------------------------------------------------------------
### Get mortality.org data
### --------------------------------------------------------------------------------------

stmf <- get_stmf(skip = 2) %>%
  rename(deaths_total = d_total, rate_total = r_total) %>%
  select(country_code:sex, deaths_total, rate_total, split:forecast, everything()) %>%
  pivot_longer(
    cols = d0_14:r85p,
    names_to = c("measure", "age_group"),
    names_pattern = "(r|d)(.*)"
  ) %>%
  pivot_wider(names_from = measure,
              values_from = value) %>%
  mutate(age_group = stringr::str_replace(age_group, "_", "-"),
         age_group = stringr::str_replace(age_group, "p", "+")) %>%
  rename(death_count = d, death_rate = r) %>%
  mutate(approx_date = paste0(year, "-", "W", stringr::str_pad(week, width = 2, pad = "0"), "-", "7"),
         approx_date = ISOweek::ISOweek2date(approx_date)) %>%
  select(country_code:sex, split:forecast, approx_date, approx_date, age_group:death_rate, deaths_total, rate_total)


md_ccodes <- tibble(country_code = unique(stmf$country_code)) %>%
  left_join(countries, by = c("country_code" = "iso3")) %>%
  mutate(cname = replace(cname, country_code == "DEUTNP", "Germany"),
         iso2 = replace(iso2, country_code == "DEUTNP", "DE"),
         cname = replace(cname, country_code == "FRATNP", "France"),
         iso2 = replace(iso2, country_code == "FRATNP", "FR"),
         cname = replace(cname, country_code == "GBRTENW", "England and Wales"),
         cname = replace(cname, country_code == "GBR_SCO", "Scotland")
         ) %>%
  left_join(countries)


stmf <- left_join(stmf, md_ccodes) %>%
  select(country_code, cname:iso3, everything())


### --------------------------------------------------------------------------------------
### Get Coronanet policy data
### --------------------------------------------------------------------------------------
coronanet_raw <- get_corona_tscs()

cnet_vars <- c("record_id", "policy_id", "recorded_date", "date_announced", "date_start", "date_end",
               "entry_type", "event_description", "domestic_policy", "type", "type_sub_cat",
               "type_text", "index_high_est", "index_med_est", "index_low_est", "index_country_rank",
               "country", "init_country_level", "province", "target_country", "target_geog_level",
               "target_region", "target_province", "target_city", "target_other", "target_who_what",
               "target_direction", "travel_mechanism", "compliance", "enforcer", "link", "iso_a3", "iso_a2")

coronanet <- coronanet_raw %>%
  select(all_of(cnet_vars)) %>%
  rename(iso3 = iso_a3, iso2 = iso_a2)

### --------------------------------------------------------------------------------------
### US Census Population Estimates for States
### --------------------------------------------------------------------------------------

statefips <- read_csv(here("data-raw/data/state_fips_master.csv")) %>%
  select(state_name, state_abbr, region_name, division_name) %>%
  rename(state = state_name)

uspop <- read_csv(here("data-raw/data/PEP_2018_PEPSR6H_with_ann.csv")) %>%
  janitor::clean_names() %>%
  filter(estimate == "est72018", !is.na(statefips)) %>%
  select(sex_id:tom) %>%
  left_join(statefips) %>%
  select(state, state_abbr, statefips, region_name, division_name, everything())

### --------------------------------------------------------------------------------------
### Write out the data objects
### --------------------------------------------------------------------------------------

## Apple and Google
usethis::use_data(apple_mobility, overwrite = TRUE, compress = "xz")
usethis::use_data(google_mobility, overwrite = TRUE, compress = "xz")

## CDC surveillance
usethis::use_data(cdc_hospitalizations, overwrite = TRUE, compress = "xz")
usethis::use_data(cdc_deaths_by_week, overwrite = TRUE, compress = "xz")
usethis::use_data(cdc_deaths_by_age, overwrite = TRUE, compress = "xz")
usethis::use_data(cdc_deaths_by_sex, overwrite = TRUE, compress = "xz")
usethis::use_data(cdc_deaths_by_state, overwrite = TRUE, compress = "xz")
usethis::use_data(cdc_catchments, overwrite = TRUE, compress = "xz")
usethis::use_data(nssp_covid_er_nat, overwrite = TRUE, compress = "xz")
usethis::use_data(nssp_covid_er_reg, overwrite = TRUE, compress = "xz")

## NCHS
usethis::use_data(nchs_sas, overwrite = TRUE, compress = "xz")
usethis::use_data(nchs_wss, overwrite = TRUE, compress = "xz")
usethis::use_data(nchs_pud, overwrite = TRUE, compress = "xz")

## CoronaNet
usethis::use_data(coronanet, overwrite = TRUE, compress = "xz")

## COVID Tracking Project
usethis::use_data(covus, overwrite = TRUE, compress = "xz")

usethis::use_data(covus_race, overwrite = TRUE, compress = "xz")
usethis::use_data(covus_ethnicity, overwrite = TRUE, compress = "xz")


## Country codes
usethis::use_data(countries, overwrite = TRUE, compress = "xz")

## ECDC
usethis::use_data(covnat, overwrite = TRUE, compress = "xz")

## Mortality.org
usethis::use_data(stmf, overwrite = TRUE, compress = "xz")

## NYT
usethis::use_data(nytcovcounty, overwrite = TRUE, compress = "xz")
usethis::use_data(nytcovstate, overwrite = TRUE, compress = "xz")
usethis::use_data(nytcovus, overwrite = TRUE, compress = "xz")
usethis::use_data(nytexcess, overwrite = TRUE, compress = "xz")

## US State pops
usethis::use_data(uspop, overwrite = TRUE, compress = "xz")


## rd skeleton
#sinew::makeOxygen("uspop")
sinew::makeOxygen("nchs_pud")

document()

knit("README.Rmd")
system("sed -i '' '1,4d' README.md")


test()



