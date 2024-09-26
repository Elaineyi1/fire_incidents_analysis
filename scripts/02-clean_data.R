#### Preamble ####
# Purpose: Clean the raw hate crimes data from Open Data Toronto
# Author: Boxuan Yi
# Email: boxuan.yi@mail.utoronto.ca
# Date: 19 September 2024
# Prerequisites: None

library(dplyr)
library(tidyverse)
library(here)
library(janitor)
library(knitr)

# Read the raw dataset
data_raw <- read_csv(file = here("../inputs/data/data_raw.csv"))

# Clean the names, eliminate NA, and create an occurrence month column
data_cleaned <- clean_names(data_raw)
data_cleaned <- na.omit(data_cleaned)
data_cleaned$occurrence_month <- as.numeric(substr(data_cleaned$occurrence_date, 6, 7))

# Modify the religion bias column
data_cleaned <- data_cleaned |>
  filter(!(religion_bias %in% c("Christian Orthodox, Jewish", "Jewish, Muslim"))) |>
  mutate(religion_bias = case_when(
    religion_bias %in% c("Anglican", "Other Christian Religion", "Christian Orthodox") ~ "Christian",
    TRUE ~ religion_bias
  ))

# Modify the race bias column
data_cleaned <- data_cleaned |>
  filter(!(race_bias %in% c("Black, East/Southeast Asian", "Black, Indigenous", "Black, South Asian", 
                            "Black, White", "East/Southeast Asian, South Asian, Black", 
                            "Indigenous, East/Southeast Asian", "White, East/Southeast Asian", 
                            "Other race not mentioned"))) |>
  mutate(race_bias = case_when(
    race_bias %in% c("Black") ~ "Black",
    race_bias %in% c("East/Southeast Asian") ~ "East/Southeast Asian",
    race_bias %in% c("Indigenous") ~ "Indigenous",
    race_bias %in% c("Latino") ~ "Latino",
    race_bias %in% c("Middle Eastern") ~ "Middle Eastern",
    race_bias %in% c("South Asian") ~ "South Asian",
    race_bias %in% c("White") ~ "White",
    TRUE ~ race_bias
  ))

# Modify the location type column
data_cleaned <- data_cleaned |>
  mutate(location_type = case_when(
    location_type %in% c("Government Building", "Government Building (Courthouse, Museums, Parliament Building, etc.)", "Non-Commercial/Non for Profit") ~ "Government/Public Buildings",
    location_type %in% c("Apartment Building (Condo, Retirement Buidling, etc.)", "House (Townhouse, Retirement Home, Garage, Vehicle, Cottage)") ~ "Residential",
    location_type %in% c("Business/Retail", "Other Commercial / Corporate Places") ~ "Commercial/Business",
    location_type == "Medical Facility (Hospitals, Long-term Care, etc.)" ~ "Healthcare",
    location_type == "Educational Institution (Universities, Colleges, Schools, etc.)" ~ "Educational",
    location_type %in% c("Open Area, Park or Parking Lot", "Streets/Roadways/Highway", "Public Transportation") ~ "Public Spaces/Transportation",
    location_type == "Religious Place of Worship/Cultural Centre" ~ "Religious",
    TRUE ~ location_type  # If any unhandled cases, keep original
  ))

# Create a simplified column that describes the primary offence
data_cleaned <- data_cleaned |>
  mutate(primary_offence_simplified = case_when(
    primary_offence %in% c("Wilful Promotion of Hatred", "Public Incitement of Hatred", "Advocating Genocide") ~ "Hatred",
    primary_offence %in% c("Assault", "Assault With a Weapon", "Assault Causing Bodily Harm", "Assault Peace Officer", "Aggravated Assault") ~ "Assault",
    primary_offence %in% c("Mischief Under $5000", "Mischief Interfere With Property", "Mischief To Religious Property, Educational Institutions, Etc.", "Mischief Over $5000", "Mischief To Data", "Arson", "Theft", "Robbery") ~ "Property Crimes",
    primary_offence %in% c("Uttering Threats - Bodily Harm", "Uttering Threats - Property", "Criminal Harassment", "Harassing Communications", "Disturbing Religious Worship Or Certain Meetings", "Causing a Disturbance") ~ "Threats and Harassment",
    primary_offence == "Sexual Assault" ~ "Sexual Offences",
    primary_offence %in% c("Murder", "Dangerous Operation Motor Vehicle") ~ "Violent Crimes",
    TRUE ~ "Other Offences"  # for any other offences not categorized
  ))

# Mutate a division area column
data_cleaned <- data_cleaned |>
  mutate(
    division_area =
      case_match(
        division,
        "D41" ~ "Scarborough",
        "D42" ~ "Scarborough",
        "D43" ~ "Scarborough",
        "D51" ~ "Toronto-East York",
        "D52" ~ "Toronto-East York",
        "D53" ~ "Toronto-East York",
        "D55" ~ "Toronto-East York",
        "D31" ~ "North York",
        "D32" ~ "North York",
        "D33" ~ "North York",
        "D22" ~ "Etobicoke",
        "D23" ~ "Etobicoke",
        "D11" ~ "Etobicoke-York",
        "D12" ~ "Etobicoke-York",
        "D13" ~ "Etobicoke-York",
        "D14" ~ "Etobicoke-York",
        "NSA" ~ "Other"))

# write the cleaned dataset
write_csv (
  x = data_cleaned,
  file = "downloads/hate_crime/inputs/data/data_cleaned.csv"
)
