# Paroxysmal Atrial Fibrillation Prediction Analysis

## Load Required Libraries
library(survival)
library(dplyr)
library(openxlsx)

## Data Loading
# Load your dataset
# Replace 'path_to_data' with the actual path
data <- read.csv('path_to_data')

## Baseline Characteristics Table
# Create a baseline characteristics table
baseline_table <- data %>% 
  summarize(
    Count = n(),
    Mean_Age = mean(age, na.rm = TRUE),
    Gender = table(gender)
  )

## Survival Analysis
# Create a survival object
surv_obj <- Surv(time = data$time_to_event, event = data$event)

# Fit survival model
surv_fit <- survfit(surv_obj ~ treatment_group, data = data)

# Calculate Hazard Ratios
cox_model <- coxph(surv_obj ~ treatment_group + age + gender, data = data)
summary(cox_model)

# Extract Hazard Ratios
hazard_ratios <- exp(coef(cox_model))

## Export to Word Document
# Install and load the officer package
# install.packages('officer')
library(officer)

# Create a Word document
doc <- read_docx()

# Add content to Word document
# Title
doc <- doc %>% 
  body_add_par('Paroxysmal Atrial Fibrillation Analysis Report', style = 'heading 1')

# Baseline characteristics table
# Add Baseline Table in the document
doc <- doc %>% 
  body_add_table(baseline_table, style = 'table_template')

# Survival Analysis Results
# Add survival fit results in document
s <- summary(surv_fit)
doc <- doc %>% 
  body_add_par('Survival Analysis Results:', style = 'heading 2')

# Save the Word Document
print(doc, target = 'paroxysmal_af_analysis_report.docx')

# Save all objects if needed
save(baseline_table, surv_fit, cox_model, file = 'af_analysis_results.RData')