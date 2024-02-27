---
description: Example how to filter a tibble by named parameters defined in list
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
                one_number = 3,
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
  dplyr::filter(numbers<parameter[["one_number"]]) %>%  # keep smaller than upper limit number
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

Use parameters for grouping

```r
test_data<-tibble(grouping_col_01=c("one","one", "one", "two","two"),
                  grouping_col_02=c("A","B","A","B","A"),
                  numbers=c(1,2,3,4,5),
                  letters=c("a","b","c","d","e")
)

grouping_cols<-grep("grouping",colnames(test_data))

test_data %>%
  group_by(across(all_of(grouping_cols))) %>% 
  summarise(n=n())
  
  
```

Print original and summazid grouped table

```
> print(test_data)
# A tibble: 5 × 4
  grouping_col_01 grouping_col_02 numbers letters
  <chr>           <chr>             <dbl> <chr>  
1 one             A                     1 a      
2 one             B                     2 b      
3 one             A                     3 c      
4 two             B                     4 d      
5 two             A                     5 e      


> test_data %>%
+   group_by(across(all_of(grouping_cols))) %>% 
+   summarise(n=n())
`summarise()` has grouped output by 'grouping_col_01'. You can override using the `.groups` argument.
# A tibble: 4 × 3
# Groups:   grouping_col_01 [2]
  grouping_col_01 grouping_col_02     n
  <chr>           <chr>           <int>
1 one             A                   2
2 one             B                   1
3 two             A                   1
4 two             B                   1
```
