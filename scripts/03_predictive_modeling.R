# ==============================================================================
# Step 4: Machine Learning Modeling & Validation Pipeline — Group 3
# ==============================================================================
if(!require(caTools)) install.packages("caTools", dependencies=TRUE)
if(!require(randomForest)) install.packages("randomForest", dependencies=TRUE)

library(tidyverse)
library(caTools)
library(randomForest)

set.seed(42)

# 1. Partition dataset into 80% Training and 20% Testing sets
split <- sample.split(traffic_cleaned$Vehicles, SplitRatio = 0.8)
train_set <- subset(traffic_cleaned, split == TRUE)
test_set  <- subset(traffic_cleaned, split == FALSE)

# Balance computation speed during defense runs using representative samples
train_sample <- train_set %>% sample_n(5000)

# 2. Fit Baseline Model: Multiple Linear Regression
lm_model <- lm(Vehicles ~ Hour + IsWeekend + Junction, data = train_sample)

# 3. Fit Advanced Ensemble Model: Random Forest Regressor
rf_model <- randomForest(Vehicles ~ Hour + IsWeekend + Junction, data = train_sample, ntree = 100)

# 4. Compute Pipeline Predictions on Independent Test Matrix
test_set$pred_lm <- predict(lm_model, newdata = test_set)
test_set$pred_rf <- predict(rf_model, newdata = test_set)

# 5. Define Empirical Metric Evaluation Structure
calculate_metrics <- function(actual, predicted) {
  rmse <- sqrt(mean((actual - predicted)^2))
  mae  <- mean(abs(actual - predicted))
  return(c(RMSE = rmse, MAE = mae))
}

metrics_lm <- calculate_metrics(test_set$Vehicles, test_set$pred_lm)
metrics_rf <- calculate_metrics(test_set$Vehicles, test_set$pred_rf)

# 6. Construct Comparative Performance View Matrix
model_evaluation_matrix <- data.frame(
  Model = c("Multiple Linear Regression", "Random Forest Regressor"),
  RMSE  = c(metrics_lm["RMSE"], metrics_rf["RMSE"]),
  MAE   = c(metrics_lm["MAE"], metrics_rf["MAE"])
)

# 7. Print formal data matrix findings directly to the runtime session
print("=========================================================")
print("             GROUP 3: MODEL PERFORMANCE EVALUATION        ")
print("=========================================================")
print(model_evaluation_matrix)
