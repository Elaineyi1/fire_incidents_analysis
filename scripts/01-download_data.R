#### Preamble ####
# Purpose: Download and read in the hate crimes data from Open Data Toronto
# Author: Boxuan Yi
# Email: boxuan.yi@mail.utoronto.ca
# Date: 15 September 2024
# Prerequisites: None

# install.packages('opendatatoronto')
# install.packages('dplyr')
# install.packages('tidyverse')
# install.packages('here')
# install.packages('janitor')
# install.packages('knitr')
# install.packages('ggplot2')

library(opendatatoronto)
library(dplyr)
library(tidyverse)
library(here)
library(janitor)

# get package
package <- show_package("hate-crimes-open-data")

# get all resources for this package
resources <- list_package_resources("hate-crimes-open-data")
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))
data_raw <- filter(datastore_resources, row_number()==1) %>% get_resource()

# write data
write_csv (
  x = data_raw,
  file = "downloads/hate_crime/inputs/data/data_raw.csv"
)
