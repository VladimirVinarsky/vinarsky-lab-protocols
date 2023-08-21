---
description: Filtering by file now possible in R
---

# Filter table by file

## Files

{% file src="../.gitbook/assets/data-source.txt" %}
example file to be filtered
{% endfile %}

{% file src="../.gitbook/assets/filter-1.txt" %}
example filter file
{% endfile %}

{% file src="../.gitbook/assets/read-and-filter.R" %}
file with the actual code
{% endfile %}

{% code overflow="wrap" %}
```r
library(tidyverse)
library(rstudioapi)

#set the working directory etc
working_directory<-rstudioapi::getActiveDocumentContext()
setwd(working_directory$path)
getwd()

# load the files into strings, change to upper case and trim the whitespace from both ends
data_filter<-str_trim( toupper( read_lines("filter-1.txt" ) ) )
data_source_strings<-str_trim( toupper( read_lines("data-source.txt" ) ) )


# make a dummy tibble
data_source_numbers<-seq(1:length(data_source_strings))
data_source<-tibble(data_source_numbers,data_source_strings)

# Now I need to prepare the strings which contain the regular expressin understood by grep
# define the start and end anchors
start_anchor<-"^"
end_anchor<-"$"

#put the anchores at the start and end of each vector item
filter_anchored_start<-paste0(start_anchor,data_filter)
filter_anchored_end<-paste0(data_filter,end_anchor)

#collapse the filter vectors into filter strings - the individual vector components are separated with "|" which is logical OR 
filter_exact_match_collapsed<-paste(data_filter, collapse ="|")
filter_anchored_start_collapsed<-paste(filter_anchored_start , collapse ="|")
filter_anchored_end_collapsed<-paste0(filter_anchored_end,collapse ="|")


# Filtering part
# Keep only such rows of the data_source tibble where there are matches with filter strings:
# 1. get the exact match (here we cannot use the regular expressions defined above but %in% operator)
match_exact<-data_source %>% 
  dplyr::filter(data_source_strings %in% data_filter)

# 2. get the anywhere match 
match_anywhere<-data_source %>% 
  dplyr::filter(grepl(filter_exact_match_collapsed,data_source_strings, ignore.case = TRUE))

# 3. get the match at the start
match_start<-data_source %>% 
  dplyr::filter(grepl(filter_anchored_start_collapsed,data_source_strings, ignore.case = TRUE))

# 4. get the match at the end
match_end<-data_source %>% 
  dplyr::filter(grepl(filter_anchored_end_collapsed,data_source_strings, ignore.case = TRUE))

# Prepare for output to be able to extract the different matches
matches<-list(exact = match_exact, 
              anywhere = match_anywhere, 
              start = match_start,
              end = match_end 
              )

# Print out the individual matches
walk(names(matches_result), ~ {
  cat("Name:", .x, "\n")
  print(matches_result[[.x]])
  cat("\n")
})



```
{% endcode %}

##
