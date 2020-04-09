## code to prepare `DATASET` dataset goes here
library(tidyverse)
covcurve <- read_csv("data-raw/cov_cases.csv")

usethis::use_data(covcurve, overwrite = TRUE)
