# Survival Analysis and Hazard Ratio Calculation

# Load necessary libraries
library(survival)
library(survminer)

# Sample data creation (replace this with your actual data)
data <- data.frame(
  time = c(5, 8, 12, 23, 13, 22, 11, 29, 17, 35),  # Survival time
  event = c(1, 1, 0, 1, 0, 1, 1, 0, 1, 1),          # Event occurrence (1 = event occurred, 0 = censored)
  age = c(60, 70, 65, 80, 75, 85, 55, 90, 88, 73),   # Age of patients
  gender = factor(c('male', 'female', 'female', 'male', 'female', 'male', 'female', 'male', 'female', 'male')) # Gender
)

# Fit Cox proportional hazards model
cox_model <- coxph(Surv(time, event) ~ age + gender, data = data)

# Summary of the model
summary(cox_model)

# Calculate hazard ratios
hr <- exp(coef(cox_model))
hr

# Plot survival curves
fit <- survfit(cox_model)

# Create survival plot
ggsurvplot(fit, data = data, risk.table = TRUE, pval = TRUE, conf.int = TRUE)