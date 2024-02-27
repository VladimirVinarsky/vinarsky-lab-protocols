---
description: Example how to filter a tibble by paramters defined in list
---

# Dplyr::filter

Make a test data

```r
library(tidyverse)

test_data<-tibble(numbers=c(1,2,3,4,5),
                    letters=c("a","b","c","d","e")
                    )
```

Print the table

```r
> print(test_data)
# A tibble: 5 × 2
  numbers letters
    <dbl> <chr>  
1       1 a      
2       2 b      
3       3 c      
4       4 d      
5       5 e  
```

Make a list of named parameters

```r
parameter<-list(matching_numbers = c(1,2,3,4),
                number_range = c(2,4),
                one_matching_number = 3,
                letter = "b"
                )
```

Filter the data table (tibble)

```r
filtered_output<-test_data %>% 
  dplyr::filter(numbers %in% parameter[["matching_numbers"]]) %>% # keep matching numbers
  dplyr::filter(between(numbers, # keep only numbers inside a range
                        min(parameter[["number_range"]]),
                        max(parameter[["number_range"]]))
                ) %>% 
  dplyr::filter(numbers<parameter[["one_matching_number"]]) %>%  # keep smaller than upper limit number
  dplyr::filter(letters==parameter[["letter"]]) # keep matching letter
```

Print the filtered result

```r
> print(filtered_output)
# A tibble: 1 × 2
  numbers letters
    <dbl> <chr>  
1       2 b   
```
