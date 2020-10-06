## Testing the datasets to see if they are as expected
context("Validating package data objects")
library(covdata)


## countries
test_that("countries conforms to spec", {
  countries_colnames <- c("cname", "iso3", "iso2", "continent")
  expect_equal(colnames(countries), countries_colnames)
})


## covnat
test_that("covnat conforms to spec", {
  covnat_colnames <- c("date", "cname", "iso3", "cases", "deaths", "pop",  "cu_cases",  "cu_deaths")
  expect_equal(colnames(covnat), covnat_colnames)
})


## covus
test_that("covus conforms to spec", {
  covus_colnames <- c("date", "state", "fips", "data_quality_grade", "measure", "count", "measure_label")
  expect_equal(colnames(covus), covus_colnames)

  covus_measure_names <- c("positive",
                           "probable_cases",
                           "negative",
                           "pending",
                           "hospitalized_currently",
                           "hospitalized_cumulative",
                           "in_icu_currently",
                           "in_icu_cumulative",
                           "on_ventilator_currently",
                           "on_ventilator_cumulative",
                           "recovered",
                           "death",
                           "total_tests_viral",
                           "positive_tests_viral",
                           "negative_tests_viral",
                           "positive_cases_viral",
                           "death_confirmed",
                           "death_probable",
                           "total_test_encounters_viral",
                           "total_tests_people_viral",
                           "total_tests_antibody",
                           "positive_tests_antibody",
                           "negative_tests_antibody",
                           "total_tests_people_antibody",
                           "positive_tests_people_antibody",
                           "negative_tests_people_antibody",
                           "total_tests_people_antigen",
                           "positive_tests_people_antigen",
                           "total_tests_antigen",
                           "positive_tests_antigen")
  expect_equal(unique(covus$measure), covus_measure_names)


})


test_that("covus_race conforms to spec", {
  covus_race_colnames <- c("date", "state", "group", "cases", "deaths")
  expect_equal(colnames(covus_race), covus_race_colnames)

})

test_that("covus_ethnicity conforms to spec", {
  covus_ethnicity_colnames <- c("date", "state", "group", "cases", "deaths")
  expect_equal(colnames(covus_ethnicity), covus_ethnicity_colnames)

})


## nytcovcounty
test_that("nytcovcounty conforms to spec", {
  nytcovcounty_colnames <- c("date", "county", "state", "fips", "cases", "deaths")
  expect_equal(colnames(nytcovcounty), nytcovcounty_colnames)
})


## nytcovstate
test_that("nytcovstate conforms to spec", {
  nytcovstate_colnames <- c("date", "state", "fips", "cases", "deaths")
  expect_equal(colnames(nytcovstate), nytcovstate_colnames)
})

## nytcovus
test_that("nytcovus conforms to spec", {
  nytcovus_colnames <- c("date", "cases", "deaths")
  expect_equal(colnames(nytcovus), nytcovus_colnames)
})

## nytexcess
test_that("nytexcess conforms to spec", {
  nytexcess_colnames <- c("country", "placename", "frequency", "start_date", "end_date",
                          "year", "month", "week", "deaths", "expected_deaths", "excess_deaths", "baseline")
  expect_equal(colnames(nytexcess), nytexcess_colnames)
})

## cdc_hospitalizations
test_that("cdc_hospitalizations conforms to spec", {
  cdc_hospitalizations_colnames <- c("catchment", "network", "year", "mmwr_year",
                                     "mmwr_week", "age_category", "cumulative_rate", "weekly_rate")
  expect_equal(colnames(cdc_hospitalizations), cdc_hospitalizations_colnames)
})

## cdc_deaths_by_week
test_that("cdc_deaths_by_week conforms to spec", {
  cdc_deaths_by_week_colnames <- c("data_as_of", "start_week", "end_week",
  "covid_deaths", "total_deaths", "percent_expected_deaths",
  "pneumonia_deaths", "pneumonia_and_covid_deaths", "all_influenza_deaths_j09_j11",
  "pneumonia_influenza_and_covid_19_deaths")
  expect_equal(colnames(cdc_deaths_by_week), cdc_deaths_by_week_colnames)
})

## cdc_deaths_by_age
test_that("cdc_deaths_by_age conforms to spec", {
  cdc_deaths_by_age_colnames <- c("data_as_of", "age_group", "start_week", "end_week", "covid_deaths",
                                  "total_deaths", "percent_expected_deaths", "pneumonia_deaths",
                                  "pneumonia_and_covid_deaths", "all_influenza_deaths_j09_j11")
  expect_equal(colnames(cdc_deaths_by_age), cdc_deaths_by_age_colnames)
})

## cdc_deaths_by_sex
test_that("cdc_deaths_by_sex conforms to spec", {
  cdc_deaths_by_sex_colnames <- c("data_as_of", "sex", "start_week", "end_week", "covid_deaths",
                                  "total_deaths", "percent_expected_deaths", "pneumonia_deaths",
                                  "pneumonia_and_covid_deaths", "all_influenza_deaths_j09_j11")
  expect_equal(colnames(cdc_deaths_by_sex), cdc_deaths_by_sex_colnames)
})

## cdc_catchments
test_that("cdc_catchments conforms to spec", {
  cdc_catchments_colnames <- c("name", "area")
  expect_equal(colnames(cdc_catchments), cdc_catchments_colnames)
})

## nssp_covid_er_nat
test_that("nssp_covid_er_nat conforms to spec", {
  nssp_covid_er_nat_colnames <- c("week", "num_fac", "total_ed_visits", "visits",
                                  "pct_visits", "visit_type", "region", "source", "year")
  expect_equal(colnames(nssp_covid_er_nat), nssp_covid_er_nat_colnames)
})

## nssp_covid_er_reg
test_that("nssp_covid_er_reg conforms to spec", {
  nssp_covid_er_reg_colnames <- c("week", "num_fac", "total_ed_visits", "visits",
                                  "pct_visits", "visit_type", "region", "source", "year")
  expect_equal(colnames(nssp_covid_er_reg), nssp_covid_er_reg_colnames)
})

## stmf
test_that("stmf conforms to spec", {
  stmf_colnames <- c("country_code", "cname", "iso2", "continent", "iso3", "year",
                     "week", "sex", "split", "split_sex", "forecast", "approx_date",
                     "age_group", "death_count", "death_rate", "deaths_total", "rate_total")
  expect_equal(colnames(stmf), stmf_colnames)
})

## apple_mobility
test_that("apple_mobility conforms to spec", {
  apple_mobility_colnames <- c("geo_type", "region", "transportation_type",
                               "alternative_name", "sub_region", "country", "date", "score")
  expect_equal(colnames(apple_mobility), apple_mobility_colnames)
})

## google_mobility
# test_that("google_mobility conforms to spec", {
#   google_mobility_colnames <- c("country_region_code", "country_region", "sub_region_1",
#                                 "sub_region_2", "metro_area", "iso3166_2", "census_fips_code", "date", "type", "pct_diff")
#   expect_equal(colnames(google_mobility), google_mobility_colnames)
# })

## coronanet
test_that("coronanet conforms to spec", {
  coronanet_colnames <- c("record_id", "policy_id", "entry_type", "correct_type", "update_type", "update_level",
                          "description", "date_announced", "date_start", "date_end", "country", "iso3",
                          "iso2", "init_country_level", "domestic_policy", "province", "city", "type",
                          "type_sub_cat", "type_text", "school_status", "target_country", "target_geog_level", "target_region",
                          "target_province", "target_city", "target_other", "target_who_what", "target_direction", "travel_mechanism",
                          "compliance", "enforcer", "index_high_est", "index_med_est", "index_low_est", "index_country_rank",
                          "link", "date_updated", "recorded_date")
  expect_equal(colnames(coronanet), coronanet_colnames)
})

## uspop
test_that("uspop conforms to spec", {
  uspop_colnames <- c("state", "state_abbr", "statefips", "region_name", "division_name",
                      "sex_id", "sex", "hisp_id", "hisp_label", "fips", "pop", "white",
                      "black", "amind", "asian", "nhopi", "tom")
  expect_equal(colnames(uspop), uspop_colnames)
})


## nchs_sas
test_that("nchs_sas conforms to spec", {
  nchs_sas_colnames <- c("data_as_of", "start_week", "end_week", "state", "sex", "age_group", "covid_19_deaths",
                     "total_deaths", "pneumonia_deaths", "pneumonia_and_covid_19_deaths", "influenza_deaths",
                     "pneumonia_influenza_or_covid_19_deaths")
  expect_equal(colnames(nchs_sas), nchs_sas_colnames)
})


## nchs_wss
test_that("nchs_wss conforms to spec", {
  nchs_wss_colnames <- c("data_as_of", "start_week", "end_week", "state", "group", "deaths", "dist_pct", "uw_dist_pop_pct", "wt_dist_pop_pct")
  expect_equal(colnames(nchs_wss), nchs_wss_colnames)

  nchs_wss_groups <- c("Non-Hispanic White", "Non-Hispanic Black or African American", "Non-Hispanic American Indian or Alaska Native",
                       "Non-Hispanic Asian", "Hispanic or Latino", "Other")
  expect_equal(unique(nchs_wss$group), nchs_wss_groups)
})


## nchs_pud
test_that("nchs_pud conforms to spec", {
  nchs_pud_colnames <- c("cdc_report_dt", "pos_spec_dt", "onset_dt", "current_status", "sex",
                         "age_group", "race_ethnicity", "hosp_yn", "icu_yn", "death_yn",
                         "medcond_yn"   )
  expect_equal(colnames(nchs_pud), nchs_pud_colnames)
})


## nchs_wdc
test_that("nchs_wdc conforms to spec", {
  nchs_wdc_colnames <- c("jurisdiction", "year", "week", "week_ending_date", "cause_detailed", "n", "cause")
  expect_equal(colnames(nchs_wdc), nchs_wdc_colnames)

  nchs_wdc_causes <- c("All Cause"                                                                                       ,
                       "Alzheimer disease (G30)"                                                                          ,
                       "Cerebrovascular diseases (I60-I69)"                                                               ,
                       "Chronic lower respiratory diseases (J40-J47)"                                                     ,
                       "Diabetes mellitus (E10-E14)"                                                                      ,
                       "Diseases of heart (I00-I09,I11,I13,I20-I51)"                                                      ,
                       "Influenza and pneumonia (J10-J18)"                                                                ,
                       "Malignant neoplasms (C00-C97)"                                                                    ,
                       "Natural Cause"                                                                                    ,
                       "Nephritis, nephrotic syndrome and nephrosis (N00-N07,N17-N19,N25-N27)"                            ,
                       "Other diseases of respiratory system (J00-J06,J30-J39,J67,J70-J98)"                               ,
                       "Septicemia (A40-A41)"                                                                             ,
                       "Symptoms, signs and abnormal clinical and laboratory findings, not elsewhere classified (R00-R99)",
                       "COVID-19 (U071, Multiple Cause of Death)"                                                         ,
                       "COVID-19 (U071, Underlying Cause of Death)"                                                       ,
                       "Influenza and pneumonia (J09-J18)")
  expect_equal(unique(nchs_wdc$cause_detailed), nchs_wdc_causes)
})



