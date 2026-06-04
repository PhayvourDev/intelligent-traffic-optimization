# ==============================================================================
# Step 1 & 2: Data Cleaning & Feature Engineering — Group 3 Script
# ==============================================================================
library(tidyverse)

# 1. Load the raw dataset 
if (file.exists("data/traffic_data.csv")) {
  traffic_data <- read_csv("data/traffic_data.csv")
} else {
  print("Using existing global environment traffic_data variables.")
}

# 2. Execute Cleaning and Feature Architecture Pipeline
traffic_cleaned <- traffic_data %>%
  rename_with(tolower) %>%
  rename(
    Vehicles = vehicles,
    Junction = junction
  ) %>%
  mutate(
    DateTime = as.POSIXct(datetime, format = "%Y-%m-%d %H:%M:%S")
  ) %>%
  select(-datetime) %>%
  mutate(
    Hour      = as.numeric(format(DateTime, "%H")),
    Dayofweek = as.numeric(format(DateTime, "%u")), 
    Month     = as.numeric(format(DateTime, "%m")),
    Year      = as.numeric(format(DateTime, "%Y")),
    IsWeekend = ifelse(Dayofweek %in% c(6, 7), 1, 0)
  ) %>%
  mutate(
    Junction = as.factor(Junction)
  )

# 3. Verify structures before passing to visualization and model layers
print("=========================================================")
print("       GROUP 3: ENGINEERED DATASET STRUCTURAL SUMMARY     ")
print("=========================================================")
glimpse(traffic_cleaned)
