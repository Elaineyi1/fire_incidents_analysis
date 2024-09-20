#### Preamble ####
# Purpose: Simulate the data used for analyzing hate crimes in Toronto
# Author: Boxuan Yi
# Email: boxuan.yi@mail.utoronto.ca
# Date: 19 September 2024
# Prerequisites: None

library(tibble)

# Define the lists
race <- c("None", "Black", "Indigenous", "White", 
          "East/Southeast Asian", "Middle Eastern", 
          "South Asian", "Latino")

religion <- c("Jewish", "None", "Muslim", "Christian", 
              "Sikh", "Catholic", "Hindu")

primary_offence <- c("Hate Crimes", "Property Crimes", "Assault", 
                     "Threats and Harassment", "Other Offences", 
                     "Sexual Offences", "Violent Crimes")

division_area <- c("Etobicoke-York", "Toronto-East York", 
                   "North York", "Scarborough", "Other", 
                   "Etobicoke")

location_type <- c("Commercial/Business", "Public Spaces/Transportation", 
                   "Government/Public Buildings", "Residential", 
                   "Educational", "Healthcare", "Religious")


# Simulate the data using the lists
set.seed(123)
simulated_data <-
  tibble(
    "ID" = 1:500,
    "occurrence_year" = sample(2018:2023, 500, replace = TRUE),
    "occurrence_month" = sample(1:12, 500, replace = TRUE),
    "location_type" = sample(location_type, 500, replace = TRUE),
    "race_bias" = sample(race, 500, replace = TRUE),
    "religion_bias" = sample(religion, 500, replace = TRUE),
    "primary_offence_simplified" = sample(primary_offence, 500, replace = TRUE),
    "division_area" = sample(division_area, 500, replace = TRUE),
    "age_bias" = sample(c("NO", "YES"), 500, replace = TRUE, prob = c(0.95, 0.05)),
    "mental_or_physical_disability" = sample(c("NO", "YES"), 500, replace = TRUE, prob = c(0.95, 0.05))
  )


# Test the simulated data
class(simulated_data$occurrence_month) == 'integer'
simulated_data$occurrence_year |> min() >= 2018
simulated_data$occurrence_year |> max() <= 2023

all(unique(simulated_data$division_area) %in% c("Etobicoke-York", "Toronto-East York", 
                                              "North York", "Etobicoke", 
                                              "Scarborough", "Other"))

all(unique(simulated_data$race_bias) %in% c("None", "Black", "Indigenous", "White", 
                                          "East/Southeast Asian", "Middle Eastern", 
                                          "South Asian", "Latino"))

all(unique(simulated_data$religion_bias) %in% c("Jewish", "None", "Muslim", "Christian", 
                                              "Sikh", "Catholic", "Hindu"))

all(unique(simulated_data$mental_or_physical_disability) %in% c("NO", "YES"))

all(unique(simulated_data$age_bias) %in% c("NO","YES"))

all(unique(simulated_data$primary_offence_simplified) %in% c("Hate Crimes", "Property Crimes", 
                                                           "Assault", "Threats and Harassment", 
                                                           "Other Offences", "Sexual Offences", 
                                                           "Violent Crimes"))

