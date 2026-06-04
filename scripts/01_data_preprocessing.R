# ==============================================================================
# Step 1 & 2: Data Cleaning & Feature Engineering — Group 3 Script
# ==============================================================================
library(tidyverse)

# 1. Load the raw dataset 
# (Assumes traffic_data.csv is located in your working directory/data folder)
if (file.exists("data/traffic_data.csv")) {
  traffic_data <- read_csv("data/traffic_data.csv")
} else {
  # Fallback statement to catch existing environment variables in RStudio sessions
  print("Using existing global environment traffic_data variables.")
}

# 2. Execute Cleaning and Feature Architecture Pipeline
traffic_cleaned <- traffic_data %>%
  # Handle potential column name casing issues from the raw file
  rename_with(tolower) %>%
  rename(
    Vehicles = vehicles,
    Junction = junction
  ) %>%
  # Parse character DateTime into strict structural timestamp keys
  mutate(
    DateTime = as.POSIXct(datetime, format = "%Y-%m-%d %H:%M:%S")
  ) %>%
  # Drop old unparsed character column to keep data tidy
  select(-datetime) %>%
  # Extract rich sub-chronological dimensions for ML modeling
  mutate(
    Hour      = as.numeric(format(DateTime, "%H")),
    Dayofweek = as.numeric(format(DateTime, "%u")), # 1 = Monday, 7 = Sunday
    Month     = as.numeric(format(DateTime, "%m")),
    Year      = as.numeric(format(DateTime, "%Y")),
    # Create the behavioral feature indicator (1 = Weekend, 0 = Weekday)
    IsWeekend = ifelse(Dayofweek %in% c(6, 7), 1, 0)
  ) %>%
  # Convert Junction into an explicit categorical Factor structure
  mutate(
    Junction = as.factor(Junction)
  )

# 3. Verify structures before passing to visualization and model layers
print("=========================================================")
print("       GROUP 3: ENGINEERED DATASET STRUCTURAL SUMMARY     ")
print("=========================================================")
glimpse(traffic_cleaned)
