
#!/usr/bin/env Rscript
# Load necessary libraries
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(tidyverse))

# Functions
# Function to convert Excel-style column letters to numbers
excel_col_to_num <- function(col) {
  col <- toupper(col)  # Convert to uppercase to ensure case insensitivity
  num <- 0
  for (i in seq_along(strsplit(col, "")[[1]])) {
    num <- num * 26 + (utf8ToInt(strsplit(col, "")[[1]][i]) - utf8ToInt("A") + 1)
  }
  return(num)
}

# Function to handle the entire process
process_columns <- function(input_string) {
  # Split the input by commas to handle separate ranges/individual columns
  columns <- unlist(strsplit(input_string, ","))
  
  processed_columns <- c()  # To store final result
  
  for (col in columns) {
    if (grepl("-", col)) {  # Handle ranges (with a dash)
      range_split <- unlist(strsplit(col, "-"))
      if (grepl("^[A-Za-z]", range_split[1])) {  # Letter-based range
        start_col <- excel_col_to_num(range_split[1])
        end_col <- excel_col_to_num(range_split[2])
      } else {  # Numeric-based range
        start_col <- as.numeric(range_split[1])
        end_col <- as.numeric(range_split[2])
      }
      # Add the range in the correct format
      processed_columns <- c(processed_columns, paste(start_col, end_col, sep="-"))
      
    } else {  # Handle single columns
      if (grepl("^[A-Za-z]", col)) {  # It's a letter
        processed_columns <- c(processed_columns, excel_col_to_num(col))
      } else {  # It's a number
        processed_columns <- c(processed_columns, col)
      }
    }
  }
  
  # Join the processed columns with commas and return
  return(paste(processed_columns, collapse = ","))
}

args <- commandArgs(trailingOnly = TRUE)

# In case of no arguments return usage
if (length(args) == 0) {
  stop("\n******************
You supplied no arguments, follow usage below:
Usage: Rscript summary.R [-c columns] input-csv-file.csv # parameters in [..] are optional
How it works:
\ \ Script outputs descriptive statistics (mean, sd, N, first value, last value) per group from all columns in \"input-csv-file.csv\".
\ \ Data can be split into several datasets using grouping columns(\"Experiment No.\", \"Drug Conc.\", etc.).
\ \ Grouping columns are specified by \"-c \" followed by numbers or letters (Excel A-ZZ indexes).
\ \ \ \ a. Individual columns are separated by commas (ie \"-c 1,9\")
\ \ \ \ b. When specifying range, use dashes (ie \"-c 2-4,5-8\").
Examples:
\ \ \"-c 1,3,5-7\" will select columns 1,3,5,6,7.
\ \ \"-c A,C,E-G\" will select columns 1,3,5,6,7.
Notes:
\ \ Mixed selection (\"-c A,5-7\" is the same as \"-c 1,5-7\"), case insensitive (\"-c A\" is the same as \"-c a\").
\ \ The script requires the tidyverse and dplyr packages to be installed on your system.
vladimir.vinarsky@fnusa.cz
www.vladimir-vinarsky.me
********************"

  )
}

# Parse arguments
csv_file <- args[length(args)]  # The last argument is the CSV file
csv_file_no_ext <- tools::file_path_sans_ext(basename(csv_file))

# Find the "-c" argument (column to group by)
columns_arg <- args[which(args == "-c") + 1]

# Convert column arguments from excel to numbers
columns_args_numeric <- process_columns(columns_arg)

# Split by commas
column_parts <- unlist(strsplit(columns_args_numeric, ","))

# Initialize an empty vector to hold column indices
cols <- c()

# Process each part
for (part in column_parts) {
  part <- trimws(part)  # Remove any leading/trailing spaces
  if (grepl("-", part)) {
    # Handle range (e.g., 1-5)
    col_range <- as.numeric(unlist(strsplit(part, "-")))
    if (!any(is.na(col_range)) && length(col_range) == 2) {
      cols <- c(cols, col_range[1]:col_range[2])
    } else {
      stop("Invalid range specified: ", part)
    }
  } else {
    # Handle single number (e.g., 6, 9)
    col_num <- as.numeric(part)
    if (!is.na(col_num)) {
      cols <- c(cols, col_num)
    } else {
      stop("Invalid column number specified: ", part)
    }
  }
}

# Get the current time-date to avoid overwriting 
current_time <- Sys.time()
time_formatted<-format(current_time, "%Hh%Mm%Ss_%a-%d%b%Y")

# Load the CSV file
data <- read_csv(csv_file, show_col_types = FALSE)

# Ensure that column numbers are within the range of the data
if (any(cols > ncol(data))) {
  stop("One or more specified columns exceed the number of columns in the CSV file")
}

# Convert column indices to column names
col_names <- colnames(data)[cols]

# Group the data by the selected columns
grouped_data <- data %>%
  group_by(across(all_of(col_names))) %>%
  summarise(across(where(is.numeric), list(
    mean = ~ mean(.x, na.rm = TRUE),
    sd = ~ sd(.x, na.rm = TRUE),
    N = ~ sum(!is.na(.x)),
    first = ~ first(.x, order_by = NULL),
    last = ~ last(.x, order_by = NULL)
  ), .names = "{.col}_{.fn}"))

# Save the resulting table with "grouped_" prepended to the original file name
output_file <- paste0("summary_", csv_file_no_ext,"_", time_formatted, ".csv")
write_csv(grouped_data, output_file)
print("")
print(paste0("Time: ",time_formatted))
print(paste0("Script finished successfully"))

