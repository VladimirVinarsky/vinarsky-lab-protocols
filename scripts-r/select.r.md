---
description: Select columns from a command line using an R script
---

# Select cols

{% file src="../.gitbook/assets/select.R" %}

### Usage

`Rscript.exe select.R -c columns input-csv-file.csv`

### How it works:&#x20;

1. Script selects columns from "input-csv-file.csv" using column numbers or Excel A-ZZ indexing.
2. Columns selection is done by supplying numbers(letters):&#x20;
   * separated by commas (ie " 1,9") for individual columns&#x20;
   * separated by dashes (ie "2-4,5-8") for ranges of columns
3. Column numbers example: "-c 1,3,5-7" will select columns 1,3,5,6,7
4. Column Excel indexes example: "-c A,C,E-G" will select columns 1,3,5,6,7

### Notes:&#x20;

* The script handles also mixed selection ("-c A,5-7" is the same as "-c 1,5-7").&#x20;
* Letter indexes are case insensitive ("-c A" is the same as "-c a").&#x20;
* The script requires the "tidyverse" and "dplyr" packages to be installed on your system.&#x20;



