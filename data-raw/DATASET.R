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
                  metro_area = col_character(),
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


country_codes <- cname_table %>%
     left_join(continents) %>%
     select(iso2, iso3, cname, continent)

### --------------------------------------------------------------------------------------
### Get the data
### --------------------------------------------------------------------------------------


## Apple Mobility Data
apple_mobility <- get_apple_data() %>%
  pivot_longer(cols = starts_with("x"), names_to = "date", values_to = "index") %>%
  mutate(
    date = stringr::str_remove(date, "x"),
    date = stringr::str_replace_all(date, "_", "-"),
    date = as_date(date)) %>%
  rename(score = index)

## Google Mobility Data

# google_mobility <- get_google_data() %>%
#   rename(iso3166_2 = iso_3166_2_code,
#     retail = retail_and_recreation_percent_change_from_baseline,
#          grocery = grocery_and_pharmacy_percent_change_from_baseline,
#          parks = parks_percent_change_from_baseline,
#          transit = transit_stations_percent_change_from_baseline,
#          workplaces = workplaces_percent_change_from_baseline,
#          residential = residential_percent_change_from_baseline) %>%
#   pivot_longer(retail:residential, names_to = "type", values_to = "pct_diff")
#

### --------------------------------------------------------------------------------------
### Write out the data objects
### --------------------------------------------------------------------------------------

## Apple and Google
usethis::use_data(apple_mobility, overwrite = TRUE, compress = "xz")
# usethis::use_data(google_mobility, overwrite = TRUE, compress = "xz")

## Country codes
usethis::use_data(country_codes, overwrite = TRUE, compress = "xz")



## rd skeleton
#sinew::makeOxygen("")

document()

system("Rscript -e 'knitr::knit(\"README.Rmd\")'")
system("sed -i '' '1,4d' README.md")


test()



