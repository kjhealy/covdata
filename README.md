<!-- README.md is generated from README.Rmd. Please edit that file -->



# covdata <img src="man/figures/hex-covdata.png" align="right" width="240">

<!-- badges: start -->
[![R build status](https://github.com/kjhealy/covdata/workflows/R-CMD-check/badge.svg)](https://github.com/kjhealy/covdata/actions)
<!-- badges: end -->

## About the package

`covdata` is a data package for R that collects and bundles datasets related to [the COVID-19 pandemic](https://www.who.int/emergencies/diseases/novel-coronavirus-2019) from a variety of sources. The data are current as of Wednesday, July 22, 2020. Minimal post-processing of the data has been done in comparison to the original sources, beyond conversion to [tibbles](https://tibble.tidyverse.org) and transformation into [narrow](https://en.wikipedia.org/wiki/Wide_and_narrow_data)- or [tidy](https://en.wikipedia.org/wiki/Tidy_data) form. Occasionally some additional variables have been added (mostly [ISO country codes](https://en.wikipedia.org/wiki/ISO_3166-1)) to facilitate comparison across the datasets or their integration with other sources. 

`covdata` provides the following: 

### COVID-19 specific case and mortality data

- National-level case and mortality data from the [European Centers for Disease Control](https://www.ecdc.europa.eu/en).  
- State-level case and mortality data for the United States from the [COVID Tracking Project](https://covidtracking.com). 
- State-level and county-level case and mortality data for the United States from the [_New York Times_](https://github.com/nytimes/covid-19-data).
- Data from the US Centers for Disease Control's [Coronavirus Disease 2019 (COVID-19)-Associated Hospitalization Surveillance Network](https://www.cdc.gov/coronavirus/2019-ncov/covid-data/covidview/index.html) (COVID-NET). See below for details about this network and the scope of its coverage.
- Deidentified patient-level data from the CDC's [COVID-19 Case Surveillance Public Use Dataset](https://data.cdc.gov/Case-Surveillance/COVID-19-Case-Surveillance-Public-Use-Data/vbim-akqf). 

### All-cause mortality and excess mortality data

- National-level short-term mortality fluctuations data from the [Human Mortality Database](https://www.mortality.org).
- National-level all-cause and excess mortality estimates from the [_New York Times_](https://github.com/nytimes/covid-19-data).  

### Mobility and activity data

- Data from [Apple](http://apple.com/covid19) on relative trends in mobility in cities and countries since mid-January of 2020, based on usage of their Maps application.
- Data from [Google](https://www.google.com/covid19/mobility/data_documentation.html) on relative trends in mobility in regions and countries since mid-January of 2020, based on location and activity information.

### Policy data

- Data on policy interventions from the [CoronaNet Project](https://coronanet-project.org), providing event-based tracking of governmental policy responses to COVID-19. 

## Caveat Emptor

**The data are provided as-is**. More information about collection methods, scope, limits, and possible sources of error in the data can be found in the documentation provided by their respective sources. Follow the links above, and see the vignettes in the package. The collection and effective reporting of case and mortality data by national governments has technical and political aspects influenced by, amongst other things, the varying capacity of states to test, track and measure events in a timely fashion, the varying definitions, criteria, and methods employed by states in registering cases and deaths, and the role of politics in the exercise of capacity and the reporting of unflattering news. Researchers should take care to familiarize themselves with these issues prior to making strong claims based on these data.

## Installation

There are two ways to install the `covdata` package. 

### Install direct from GitHub

You can install covdata from [GitHub](https://github.com/kjhealy/covdata) with:

``` r
remotes::install_github("kjhealy/covdata")
```

### Installation using `drat`

While using `install_github()` works just fine, it would be nicer to be able to just type `install.packages("covdata")` or `update.packages("covdata")` in the ordinary way. We can do this using Dirk Eddelbuettel's [drat](http://eddelbuettel.github.io/drat/DratForPackageUsers.html) package. Drat provides a convenient way to make R aware of package repositories other than CRAN.

First, install `drat`:


```r
if (!require("drat")) {
    install.packages("drat")
    library("drat")
}
```

Then use `drat` to tell R about the repository where `covdata` is hosted:


```r
drat::addRepo("kjhealy")
```

You can now install `covdata`:


```r
install.packages("covdata")
```

To ensure that the `covdata` repository is always available, you can add the following line to your `.Rprofile` or `.Rprofile.site` file:


```r
drat::addRepo("kjhealy")
```

With that in place you'll be able to do `install.packages("covdata")` or `update.packages("covdata")` and have everything work as you'd expect. 

Note that my drat repository only contains data packages that are not on CRAN, so you will never be in danger of grabbing the wrong version of any other package.

## Loading the Data


```r
library(tidyverse) # Optional but strongly recommended
library(covdata)

covnat
#> # A tibble: 31,323 x 8
#> # Groups:   iso3 [209]
#>    date       cname       iso3  cases deaths       pop cu_cases cu_deaths
#>    <date>     <chr>       <chr> <dbl>  <dbl>     <dbl>    <dbl>     <dbl>
#>  1 2019-12-31 Afghanistan AFG       0      0  38041757        0         0
#>  2 2019-12-31 Algeria     DZA       0      0  43053054        0         0
#>  3 2019-12-31 Armenia     ARM       0      0   2957728        0         0
#>  4 2019-12-31 Australia   AUS       0      0  25203200        0         0
#>  5 2019-12-31 Austria     AUT       0      0   8858775        0         0
#>  6 2019-12-31 Azerbaijan  AZE       0      0  10047719        0         0
#>  7 2019-12-31 Bahrain     BHR       0      0   1641164        0         0
#>  8 2019-12-31 Belarus     BLR       0      0   9452409        0         0
#>  9 2019-12-31 Belgium     BEL       0      0  11455519        0         0
#> 10 2019-12-31 Brazil      BRA       0      0 211049519        0         0
#> # … with 31,313 more rows
```


```r
apple_mobility %>%
  filter(region == "New York City", transportation_type == "walking")
#> # A tibble: 190 x 8
#>    geo_type region        transportation_type alternative_name sub_region country       date       score
#>    <chr>    <chr>         <chr>               <chr>            <chr>      <chr>         <date>     <dbl>
#>  1 city     New York City walking             NYC              New York   United States 2020-01-13 100  
#>  2 city     New York City walking             NYC              New York   United States 2020-01-14  96.1
#>  3 city     New York City walking             NYC              New York   United States 2020-01-15 106. 
#>  4 city     New York City walking             NYC              New York   United States 2020-01-16 102. 
#>  5 city     New York City walking             NYC              New York   United States 2020-01-17 117. 
#>  6 city     New York City walking             NYC              New York   United States 2020-01-18 115. 
#>  7 city     New York City walking             NYC              New York   United States 2020-01-19 110. 
#>  8 city     New York City walking             NYC              New York   United States 2020-01-20  88.6
#>  9 city     New York City walking             NYC              New York   United States 2020-01-21  91.1
#> 10 city     New York City walking             NYC              New York   United States 2020-01-22  98.5
#> # … with 180 more rows
```


```r
covus %>% 
  filter(measure == "positive", 
         date == "2020-04-27", 
         state == "NJ")
#> # A tibble: 1 x 7
#>   date       state fips  data_quality_grade measure   count measure_label 
#>   <date>     <chr> <chr> <chr>              <chr>     <dbl> <chr>         
#> 1 2020-04-27 NJ    34    A                  positive 111188 Positive Tests
```


```r
nytcovcounty %>%
  mutate(uniq_name = paste(county, state)) %>% # Can't use FIPS because of how the NYT bundled cities
  group_by(uniq_name) %>%
  mutate(days_elapsed = date - min(date)) %>%
  ggplot(aes(x = days_elapsed, y = cases, group = uniq_name)) + 
  geom_line(size = 0.25, color = "gray20") + 
  scale_y_log10(labels = scales::label_number_si()) + 
  guides(color = FALSE) + 
  facet_wrap(~ state, ncol = 5) + 
  labs(title = "COVID-19 Cumulative Recorded Cases by US County",
       subtitle = paste("New York is bundled into a single area in this data.\nData as of", format(max(nytcovcounty$date), "%A, %B %e, %Y")),
       x = "Days since first case", y = "Count of Cases (log 10 scale)", 
       caption = "Data: The New York Times | Graph: @kjhealy") + 
  theme_minimal()
#> Don't know how to automatically pick scale for object of type difftime. Defaulting to continuous.
#> Warning: Transformation introduced infinite values in continuous y-axis
```

<img src="README-plot-1.png" title="plot of chunk plot" alt="plot of chunk plot" width="100%" />


## Documentation and Summary Codebook 

To learn more about the different datasets available, consult the vignettes or, equivalently, [the package website](https://kjhealy.github.io/covdata/articles/covdata.html). For a codebook-like summary of the variables in each table, see the [Codebook vignette](https://kjhealy.github.io/covdata/articles/codebook.html)

## Citing the `covdata` package

To cite the package use the following:


```r
citation("covdata")
#> 
#> To cite the package `covdata` in publications use:
#> 
#>   Kieran Healy. 2020. covdata: COVID-19 Case and Mortality Time Series. R package version 0.1.0,
#>   <http://kjhealy.github.io/covdata>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {covdata: COVID-19 Case and Mortality Time Series},
#>     author = {Kieran Healy},
#>     year = {2020},
#>     note = {R package version 0.1.0},
#>     url = {http://kjhealy.github.io/covdata},
#>   }
```

Please be sure to also cite the specific data sources, as described in the documentation for each dataset. 


Mask icon in hex logo by [Freepik](https://www.flaticon.com/authors/freepik).
