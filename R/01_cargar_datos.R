# Load necessary libraries
library(readxl)

# Load the data from Excel file
# Adjust the file path as necessary
excel_file <- "path/to/excel_file.xlsx"
data <- read_excel(excel_file)

# Create a new variable for grouping recurrence vs non-recurrence
# Assuming the recurrence information is in a column named 'recurrence' in the data frame
# Adjust based on actual column name in your Excel file

# Creating the 'Grupo' variable
data$Grupo <- ifelse(data$recurrence == "recurrence", "Recurrence", "Non-Recurrence")

# View the modified data frame
head(data)