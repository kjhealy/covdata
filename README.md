---
output: github_document
---

<!-- README.md is generated from README.Rmd. Please edit that file -->



# covdata

<!-- badges: start -->
<!-- badges: end -->

The goal of covdata is to make COVID-19 case data easily available.

## Installation

`covdata` is not available on CRAN. You can install it with `remotes::install_github("kjheay/covdata")`.


## Example


```r
library(tidyverse)
library(covdata)

## Countries to highlight
focus_cn <- c("CHN", "DEU", "GBR", "USA", "IRN", "JPN",
              "KOR", "ITA", "FRA", "ESP", "CHE", "TUR")

## Colors
cgroup_cols <- c(prismatic::clr_darken(paletteer_d("ggsci::category20_d3"), 0.2)[1:length(focus_cn)], "gray70")


covnat %>%
  mutate(end_label = case_when(iso3 %in% focus_cn ~ end_label,
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
       caption = "Kieran Healy @kjhealy / Data: https://www.ecdc.europa.eu/") 
#> Don't know how to automatically pick scale for object of type difftime. Defaulting to continuous.
#> Warning: Transformation introduced infinite values in continuous y-axis

#> Warning: Transformation introduced infinite values in continuous y-axis
#> Warning: Removed 9641 rows containing missing values (geom_text_repel).
```

<img src="man/figures/README-example-1.png" title="plot of chunk example" alt="plot of chunk example" width="100%" />
