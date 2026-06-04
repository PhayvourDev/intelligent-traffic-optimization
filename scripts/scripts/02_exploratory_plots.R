# ==============================================================================
# Step 3: Exploratory Data Analysis (EDA) — Group 3 Visualizations
# ==============================================================================
library(tidyverse)

# 1. Aggregate traffic counts to establish the hourly baseline profile
hourly_profile <- traffic_cleaned %>%
  group_by(Hour, IsWeekend) %>%
  summarise(Avg_Vehicles = mean(Vehicles), .groups = 'drop') %>%
  mutate(Period = ifelse(IsWeekend == 1, "Weekend", "Weekday"))

# 2. Generate Plot 1: Hourly Traffic Flow Profile Line Chart
ggplot(hourly_profile, aes(x = Hour, y = Avg_Vehicles, color = Period, group = Period)) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 2) +
  scale_x_continuous(breaks = 0:23) +
  labs(
    title = "Group 3: Smart City Traffic Flow Profile by Hour",
    subtitle = "Comparison between Weekdays and Weekends",
    x = "Hour of the Day (0-23)",
    y = "Average Vehicle Count",
    color = "Day Type"
  ) +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold", size = 14))

# 3. Generate Plot 2: Traffic Volume Distribution Boxplot across Junctions
ggplot(traffic_cleaned, aes(x = as.factor(Junction), y = Vehicles, fill = as.factor(Junction))) +
  geom_boxplot(alpha = 0.7, outlier.colour = "red", outlier.size = 0.5) +
  labs(
    title = "Group 3: Traffic Volume Distribution by Junction",
    subtitle = "Identifying city road bottlenecks and congestion anomalies",
    x = "Junction ID",
    y = "Vehicle Count (Density)",
    fill = "Junction"
  ) +
  theme_classic() +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    legend.position = "none"
  )
