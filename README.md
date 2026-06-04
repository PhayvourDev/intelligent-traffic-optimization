# intelligent-traffic-optimization
An Intelligent Urban Traffic Management and Predictive Optimization System using R and Random Forest Regressors for Smart City Infrastructure.


# Intelligent Urban Traffic Flow Optimization & Predictive Modeling System
### 🚦 Smart City Infrastructure Project — Group 3

## 📝 Project Overview
Rapid urbanization poses a severe threat to municipal transportation networks, resulting in economic losses, increased carbon emissions, and structural gridlock. This project implements a data-driven **Intelligent Traffic Optimization System** designed to identify road bottlenecks and accurately forecast vehicle densities across urban junctions. 

By leveraging **R 4.6.0** and advanced ensemble machine learning algorithms, we transform raw timestamped data streams into actionable operational windows, allowing smart city infrastructure to dynamically re-route traffic flow and adjust traffic signal arrays prior to gridlock formation.

---

## 🛠️ Data Engineering & Feature Architecture
The raw data streams (`48,120 observations`) were structurally unrefined, featuring an unparsed character time anchor and limited spatial visibility. Group 3 engineered a multi-dimensional feature matrix to capture human transit behaviors:

* **Temporal Decomposition:** Extracted `Hour`, `Dayofweek`, `Month`, and `year` attributes via `tidyverse` to map diurnal patterns and peak commuter cycles.
* **Behavioral Categorization:** Implemented an indicator variable `Isweekend` ($0$ = Weekday, $1$ = Weekend) to isolate recreational travel variations from fixed workplace commuting.
* **Spatial Factoring:** Restructured numerical spatial keys into categorical factors (`Junction`), allowing specific location tracking.

---

## 📊 Exploratory Data Insights (EDA)
Our visual analytics pipeline exposed critical structural operational patterns within the urban infrastructure grid:

### 1. Junction Traffic Density and Anomaly Spread
Our boxplot analysis isolated clear infrastructure performance variations across the monitored city sectors:
* **Junction 1:** Represents the primary commercial artery, maintaining high median density.
* **Junction 3:** Displays massive, sudden traffic volatility with acute vehicle spikes exceeding $150+$ cars, marking it as highly vulnerable to sudden bottleneck failures.
* **Junction 2 & 4:** Confirmed as highly stable, underutilized transit channels suitable for emergency vehicle or heavy freight routing diversions.

---

## 🤖 Predictive Modeling & Empirical Evaluation
To establish real-time forecasting capability, we deployed and benchmarked a baseline parametric model against an advanced machine learning algorithm on an $80/20$ split validation matrix:

1.  **Multiple Linear Regression:** Deployed as our baseline structural model to chart linear, straight-plane progression.
2.  **Random Forest Regressor (100 Trees):** An ensemble machine learning model configured to evaluate complex, non-linear intersections of time, day type, and location.

### Performance Benchmark Results
| Predictive Model Model | Root Mean Squared Error (RMSE) | Mean Absolute Error (MAE) | Operational Accuracy Rank |
| :--- | :---: | :---: | :---: |
| **Multiple Linear Regression** | 15.198 | 11.431 | Baseline Performance |
| **Random Forest Regressor** | **12.701** | **8.995** | **🏆 Champion Selected Model** |

### Key Analytical Takeaways
The **Random Forest Regressor** achieved a **$21.3\%$ reduction in absolute prediction error (MAE)** compared to the linear baseline. This performance gain occurs because the decision tree ensemble accommodates abrupt traffic surges during rush hours and non-linear localized jams at specific junctions, patterns that standard regression equations cannot adequately model.

---

## 🚀 Deployment Recommendations for Municipal Infrastructure
Based on Group 3's empirical findings, we recommend the following deployment roadmap:
1.  **Integrate Random Forest Forecasting:** Embed our champion model into the local traffic light controller layer to forecast vehicle accumulation 30 minutes into the future.
2.  **Dynamic Signal Timing:** Automatically extend green light phases at **Junction 1** and **Junction 3** when real-time forecasts indicate upcoming vehicle spikes.
3.  **Proactive Cross-Traffic Diversion:** Program municipal digital road signs to proactively redirect inbound vehicles toward **Junction 2** or **Junction 4** whenever the model predicts a major surge at Junction 3.

---

## 💻 Technical Reproduction Guide
To run this project pipeline locally, clone the repository and execute the scripts within your RStudio environment:

```r
# Step 1: Clone the repository
# git clone [https://github.com/YOUR_USERNAME/intelligent-traffic-optimization.git](https://github.com/YOUR_USERNAME/intelligent-traffic-optimization.git)

# Step 2: Open scripts/03_predictive_modeling.R and execute:
source("scripts/03_predictive_modeling.R")
