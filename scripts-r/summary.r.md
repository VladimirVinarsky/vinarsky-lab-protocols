# Summary.R

### Usage

`Rscript summary.R [-c columns] input-csv-file.csv`  parameters in \[..] are optional&#x20;

### How it works:&#x20;

* Script outputs descriptive statistics (mean, sd, N, first value, last value) per group from all columns in "input-csv-file.csv".
* Data can be split into several datasets using grouping columns("Experiment No.", "Drug Conc.", etc.).
* Grouping columns are specified by "-c " followed by numbers or letters (Excel A-ZZ indexes).
  1. Individual columns are separated by commas (ie "-c 1,9")
  2. When specifying range, use dashes (ie "-c 2-4,5-8")

### Examples:&#x20;

1. "-c 1,3,5-7" will select columns 1,3,5,6,7.&#x20;
2. "-c A,C,E-G" will select columns 1,3,5,6,7.&#x20;

### Notes:&#x20;

* Mixed selection ("-c A,5-7" is the same as "-c 1,5-7")
* Case insensitive ("-c A" is the same as "-c a").&#x20;
* The script requires the tidyverse and dplyr packages to be installed on your system.
