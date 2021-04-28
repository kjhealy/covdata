# covdata 0.7.8
- *Breaking change*: `nchs_wss`, the table of provisional death counts in the U.S. across a variety of units of observation, has had its race and ethnicity categories updated by the NCHS. The `group` column has been renamed `race_ethnicity`. A new column `obs_unit` indicates whether the results in a given row are tabulated by Total, by Year, or by Month.  

# covdata 0.7
- *Breaking change*: `covnat`, the ECDC daily dataset, has been renamed to `covnat_daily`. Daily data reporting by the ECDC was discontinued on December 14th 2020 and so this table will no longer be updated.
- A new dataset, `covnat_weekly` has been added. This is the ECDC's replacement dataset. It gives weekly national data from the beginning of the pandemic to the present.

# covdata 0.6
*Breaking change*: Removed individual-level NCHS data due to its large size. The plan is to provide more functions for the user to grab this and other data directly.

# covdata 0.5.2

*Breaking change*: The `google_mobility` dataset is getting pretty big, causing longer load times and also installation failures in some settings, e.g. on RStudio Cloud instances. I have relocated it from this package to the new [covmobility package](https://kjhealy.github.io/covmobility). `covmobility` also contains the `apple_mobility` dataset. For now, `apple_mobility` is still in `covdata` as before, though this may change.

# covdata 0.5

NCHS/CDC weekly mortality counts for 2014-2020 (useful for assessing excess deaths) are now included as `nchs_wdc`.

# covdata 0.4

*Breaking change*: The `index` variable in the `apple_mobility` dataset is now named `score`. Under the hood, various tidyverse or tidyverse-adjacent tools such as `tsibble` and `fable` use the concept of an index variable in many functions. Often it is named as `index` internally. Having a column in the data actually named `index` can lead to strange and confusing errors.

# covdata 0.3

Added the CDC's patient-level public-use dataset, as `nchs_pud`

# covdata 0.2.9

Added two tables adapted from the COVID tracking project:  
- `covus_race` provides total reported cases and deaths by state and race
- `covus_ethnicity` provides total reported cases and deaths by state and Hispanic status

See the [COVID Tracking Project Page](https://covidtracking.com/race/about) for more details on the source, scope, and limits of these counts.

# covdata 0.2.8

Added two tables from the [National Center for Health Statistics](https://www.cdc.gov/nchs/), one on death counts by sex, age and state; the other on state-level estimates of deaths by racial and ethnic group.

# covdata 0.2.7

The `pop_2018` column in `covnat` has been updated to 2019 population data and renamed `pop`. This is a breaking change for any code that used `pop_2018` to calculate, e.g., per capita rates. 
