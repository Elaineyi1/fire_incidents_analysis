#### Preamble ####
# Purpose: Test the cleaned hate crimes data
# Author: Boxuan Yi
# Email: boxuan.yi@mail.utoronto.ca
# Date: 19 September 2024
# Prerequisites: None

library(here)
library(dplyr)
library(tidyverse)

data_cleaned <- read_csv(
  file = here("../inputs/data/data_cleaned.csv"))

any(duplicated(data_cleaned$id)) == FALSE
data_cleaned$occurrence_year |> min() >= 2018
data_cleaned$occurrence_month |> class() == "numeric"
data_cleaned$occurrence_date |> class() == "Date"

all(unique(data_cleaned$division_area) %in% c("Etobicoke-York",
                                              "Toronto-East York","North York",
                                              "Etobicoke","Scarborough","Other"))
all(unique(data_cleaned$race_bias) %in% c("None", "Black", "Indigenous", "White", 
                                          "East/Southeast Asian", "Middle Eastern", 
                                          "South Asian", "Latino"))
all(unique(data_cleaned$religion_bias) %in% c("Jewish", "None", "Muslim", 
                                              "Christian", "Sikh", "Catholic", "Hindu"))
all(unique(data_cleaned$mental_or_physical_disability) %in% c("NO", "YES"))
all(unique(data_cleaned$age_bias) %in% c("NO","YES"))
all(unique(data_cleaned$primary_offence_simplified) %in% c("Hate Crimes", "Property Crimes", 
                                                           "Assault", "Threats and Harassment", 
                                                           "Other Offences", "Sexual Offences", 
                                                           "Violent Crimes"))
