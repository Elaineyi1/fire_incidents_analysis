#### Preamble ####
# Purpose: Test the cleaned hate crimes data
# Author: Boxuan Yi
# Email: boxuan.yi@mail.utoronto.ca
# Date: 17 September 2024
# Prerequisites: None

library(here)
library(dplyr)
library(tidyverse)

data_cleaned <- read_csv(
  file = here("downloads/hate_crime/inputs/data/data_cleaned.csv"))

any(duplicated(data_cleaned$id)) == FALSE
data_cleaned$occurrence_year |> min() >= 2018
data_cleaned$occurrence_month |> class() == "numeric"
data_cleaned$division |> unique()
all(unique(data_cleaned$division_area) %in% c("Etobicoke-York","Toronto-East York","North York","Etobicoke","Scarborough","Other"))
