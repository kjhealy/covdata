<!-- README.md is generated from README.Rmd. Please edit that file -->



# covdata

<!-- badges: start -->
[![Travis build status](https://travis-ci.com/kjhealy/covdata.svg?branch=master)](https://travis-ci.com/kjhealy/covdata)
<!-- badges: end -->

`covdata` is a data package for R. It provides COVID-19 case data from two sources: national level data from the [ECDC](https://www.ecdc.europa.eu/en), and state-level data for the United States from the [COVID Tracking Project](https://covidtracking.com). Data are current through April 9th, 2020.

## Installation

`covdata` is not available on CRAN. You can install it with `remotes::install_github("kjheay/covdata")`.


## Country-level Data

```r
library(tidyverse)
library(covdata)

## National level tibble
covnat
#> # A tibble: 9,653 x 8
#> # Groups:   iso3 [204]
#>    date       cname       iso3  cases deaths  pop_2018 cu_cases cu_deaths
#>    <date>     <chr>       <chr> <dbl>  <dbl>     <dbl>    <dbl>     <dbl>
#>  1 2019-12-31 Afghanistan AFG       0      0  37172386        0         0
#>  2 2019-12-31 Algeria     DZA       0      0  42228429        0         0
#>  3 2019-12-31 Armenia     ARM       0      0   2951776        0         0
#>  4 2019-12-31 Australia   AUS       0      0  24992369        0         0
#>  5 2019-12-31 Austria     AUT       0      0   8847037        0         0
#>  6 2019-12-31 Azerbaijan  AZE       0      0   9942334        0         0
#>  7 2019-12-31 Bahrain     BHR       0      0   1569439        0         0
#>  8 2019-12-31 Belarus     BLR       0      0   9485386        0         0
#>  9 2019-12-31 Belgium     BEL       0      0  11422068        0         0
#> 10 2019-12-31 Brazil      BRA       0      0 209469333        0         0
#> # … with 9,643 more rows
```


```r
## Countries to highlight
focus_cn <- c("CHN", "DEU", "GBR", "USA", "IRN", "JPN",
              "KOR", "ITA", "FRA", "ESP", "CHE", "TUR")

## Colors
cgroup_cols <- c(prismatic::clr_darken(paletteer_d("ggsci::category20_d3"), 0.2)[1:length(focus_cn)], "gray70")

covnat %>%
  filter(cu_cases > 99) %>%
  mutate(days_elapsed = date - min(date),
        end_label = ifelse(date == max(date), cname, NA),
        end_label = recode(end_label, `United States` = "USA",
                            `Iran, Islamic Republic of` = "Iran",
                            `Korea, Republic of` = "South Korea",
                            `United Kingdom` = "UK"),
         cname = recode(cname, `United States` = "USA",
                        `Iran, Islamic Republic of` = "Iran",
                        `Korea, Republic of` = "South Korea",
                        `United Kingdom` = "UK"),
         end_label = case_when(iso3 %in% focus_cn ~ end_label,
                               TRUE ~ NA_character_), 
         cgroup = case_when(iso3 %in% focus_cn ~ iso3, 
                            TRUE ~ "ZZOTHER")) %>%
  ggplot(mapping = aes(x = days_elapsed, y = cu_cases, 
         color = cgroup, label = end_label, 
         group = cname)) + 
  geom_line(size = 0.5) + 
  geom_text_repel(nudge_x = 0.75,
                  segment.color = NA) + 
  guides(color = FALSE) + 
  scale_color_manual(values = cgroup_cols) +
  scale_y_continuous(labels = scales::comma_format(accuracy = 1), 
                     breaks = 2^seq(4, 19, 1),
                     trans = "log2") + 
  labs(x = "Days Since 100th Confirmed Case", 
       y = "Cumulative Number of Reported Cases (log2 scale)", 
       title = "Cumulative Reported Cases of COVID-19, Selected Countries", 
       subtitle = paste("ECDC data as of", format(max(covnat$date), "%A, %B %e, %Y")), 
       caption = "Kieran Healy @kjhealy / Data: https://www.ecdc.europa.eu/") +
  theme_minimal()
#> Don't know how to automatically pick scale for object of type difftime. Defaulting to continuous.
#> Warning: Removed 2634 rows containing missing values (geom_text_repel).
```

<img src="man/figures/README-example-1.png" title="plot of chunk example" alt="plot of chunk example" width="100%" />


## U.S. States


```r
## US state tibble
covus
#> # A tibble: 27,216 x 11
#>    date       state fips  measure count pos_neg death_increase hospitalized_in… negative_increa… positive_increa…
#>    <date>     <chr> <chr> <chr>   <dbl>   <dbl>          <dbl>            <dbl>            <dbl>            <dbl>
#>  1 2020-04-09 AK    02    positi…   235    7223              0                0              146                9
#>  2 2020-04-09 AK    02    negati…  6988    7223              0                0              146                9
#>  3 2020-04-09 AK    02    pending    NA    7223              0                0              146                9
#>  4 2020-04-09 AK    02    hospit…    NA    7223              0                0              146                9
#>  5 2020-04-09 AK    02    hospit…    27    7223              0                0              146                9
#>  6 2020-04-09 AK    02    in_icu…    NA    7223              0                0              146                9
#>  7 2020-04-09 AK    02    in_icu…    NA    7223              0                0              146                9
#>  8 2020-04-09 AK    02    on_ven…    NA    7223              0                0              146                9
#>  9 2020-04-09 AK    02    on_ven…    NA    7223              0                0              146                9
#> 10 2020-04-09 AK    02    recove…    49    7223              0                0              146                9
#> # … with 27,206 more rows, and 1 more variable: total_test_results_increase <dbl>
```



```r
## Which n states are leading the count of positive cases or deaths?
top_n_states <- function(data, n = 5, measure = c("positive", "death")) {
  meas <- match.arg(measure)
  data %>%
  group_by(state) %>%
  filter(measure == meas, date == max(date)) %>%
  drop_na() %>%
  ungroup() %>%
  top_n(n, wt = count) %>%
  pull(state)
}

state_cols <- c("gray70", 
                prismatic::clr_darken(paletteer_d("ggsci::category20_d3"), 0.2))

covus %>%
  group_by(state) %>%
  mutate(core = case_when(state %nin% top_n_states(covus) ~ "",
                          TRUE ~ state),
         end_label = ifelse(date == max(date), core, NA)) %>%
  arrange(date) %>%
  filter(measure == "positive", date > "2020-03-09") %>%
  ggplot(aes(x = date, y = count, group = state, color = core, label = end_label)) + 
  geom_line(size = 0.5) + 
  geom_text_repel(segment.color = NA, nudge_x = 0.2, nudge_y = 0.1) + 
  scale_color_manual(values = state_cols) + 
  scale_x_date(date_breaks = "3 days", date_labels = "%b %e" ) + 
  scale_y_continuous(trans = "log2",
                     labels = scales::comma_format(accuracy = 1),
                     breaks = 2^c(seq(1, 17, 1))) +
  guides(color = FALSE) + 
  coord_equal() + 
  labs(title = "COVID-19 Cumulative Recorded Cases by US State",
       subtitle = paste("Data as of", format(max(covus$date), "%A, %B %e, %Y")),
       x = "Date", y = "Count of Cases (log 2 scale)", 
       caption = "Data: COVID Tracking Project, http://covidtracking.com | Graph: @kjhealy") + 
  theme_minimal()
#> Warning: Transformation introduced infinite values in continuous y-axis

#> Warning: Transformation introduced infinite values in continuous y-axis
#> Warning: Removed 1650 rows containing missing values (geom_text_repel).
```

<img src="man/figures/README-us-example-1.png" title="plot of chunk us-example" alt="plot of chunk us-example" width="100%" />

