# covdata 0.2.8

Added two tables from the National Center for Health Statistics, one on death counts by sex, age and state; the other on state-level estimates of deaths by racial and ethnic group.

# covdata 0.2.7

The `pop_2018` column in `covnat` has been updated to 2019 population data and renamed `pop`. This is a breaking change for any code that used `pop_2018` to calculate, e.g., per capita rates. 
