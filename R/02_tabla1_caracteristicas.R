# Load necessary libraries
library(dplyr)
library(broom)
library(flextable)
library(officer)

# Assume data is loaded in a dataframe called 'data'
# Example: data <- read.csv("path_to_your_data.csv")

# Calculate baseline characteristics
baseline_characteristics <- data %>%
  summarise(
    Mean_Age = mean(Age, na.rm = TRUE),
    SD_Age = sd(Age, na.rm = TRUE),
    N = n(),
    # Add more characteristics as needed
    .groups = 'drop'
  )

# Perform statistical tests (example: t-test)
t_test_result <- t.test(Age ~ Group, data = data)

# Convert test results to a dataframe
test_results <- tidy(t_test_result)

# Combine characteristics and p-values
final_table <- baseline_characteristics %>%
  mutate(P_Value = test_results$p.value)

# Export to Word document
doc <- read_docx() %>%
  body_add_flextable(flextable(final_table)) %>%
  body_add_par("Baseline Characteristics Table", style = "caption")

print(doc, target = "Baseline_Characteristics_Table.docx")