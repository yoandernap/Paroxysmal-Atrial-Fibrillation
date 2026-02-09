# Machine Learning Models for PAF Prediction

## Load Required Libraries
library(caret)
library(randomForest)
library(xgboost)

## Logistic Regression Model Function
logistic_regression_model <- function(training_data) {
  model <- glm(PAF ~ ., data = training_data, family = "binomial")
  return(model)
}

## Random Forest Model Function
random_forest_model <- function(training_data) {
  model <- randomForest(PAF ~ ., data = training_data)
  return(model)
}

## XGBoost Model Function
xgboost_model <- function(training_data, features) {
  dtrain <- xgb.DMatrix(data = as.matrix(training_data[, features]), label = training_data$PAF)
  model <- xgboost(data = dtrain, objective = "binary:logistic", nrounds = 100)
  return(model)
}