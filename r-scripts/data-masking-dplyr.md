---
description: >-
  Get the possibility to use vectors of names to select, group, and summarize
  datasets
---

# Data masking dplyr

## Motivation&#x20;

## Resources

{% embed url="https://dplyr.tidyverse.org/articles/programming.html" %}

{% embed url="https://rlang.r-lib.org/reference/expr.html?q=!!!syms#ref-examples" %}

## Something working for factors

```
# Example data
df <- data.frame(
  group = c("A", "B", "A", "B"),
  group2= c("AA","AA","BB","CC"),
  x = c(1, 2, 3, 4),
  y = c(5, 6, 7, 8),
  z = c(9, 10, 11, 12)
)
columns <- c("group", "group2", "x", "y")
factor_column<-columns[2]

factor_this_shit<-function(factor_column){
df %>% 
    mutate(!!sym(factor_column):=factor(.data[[factor_column]]))
  
}

a<-factor_this_shit(factor_column)
```

## Select and group\_by dynamic columns by \`syms()\` function

How to use multiple columns defined in a character vector for grouping&#x20;

```r
library(dplyr)

# Example data
df <- data.frame(
  group = c("A", "B", "A", "B"),
  x = c(1, 2, 3, 4),
  y = c(5, 6, 7, 8),
  z = c(9, 10, 11, 12)
)

# Dynamic vector of columns
columns <- c("group", "x", "y")  # Example: Can have any number of columns

# Group by dynamic columns
df %>%
  group_by(!!!syms(columns))
  
# Select by dynamic columns
df %>%
 select(!!!syms(columns))
```

## Summarize single parameter across dynamic columns

```r
library(dplyr)

# Example data
df <- data.frame(
  group = c("A", "B", "A", "B"),
  x = c(1, 2, 3, 4),
  y = c(5, 6, 7, 8),
  z = c(9, 10, 11, 12)
)

# Dynamic vector of columns
columns <- c("x", "y")  # Example: Can have any number of columns

# Generate means of dynamic columns
df %>%
  summarize(across(all_of(columns), mean))
  
  
  
```

## Summarize using multiple parameters

```r
library(dplyr)

# Example data
df <- data.frame(
  group = c("A", "B", "A", "B"),
  x = c(1, 2, 3, 4),
  y = c(5, NA, 7, 8),
  z = c(9, 10, 11, NA)
)

# Dynamic vector of columns
columns <- c("x", "y")  # Example: Can have any number of columns

# Generate means, standard deviations, and counts of dynamic columns
df %>%
  summarise(across(all_of(columns), 
                    list(mean = mean, count = ~sum(!is.na(.))),
                    .names = "{.col}_{.fn}"
                    )
            )

```

## Use the user-specified name of vriable in output

```r
my_summarise4 <- function(data, expr) {
  data %>% summarise(
    "mean_{{expr}}" := mean({{ expr }}),
    "sum_{{expr}}" := sum({{ expr }}),
    "n_{{expr}}" := n()
  )
}
my_summarise5 <- function(data, mean_var, sd_var) {
  data %>% 
    summarise(
      "mean_{{mean_var}}" := mean({{ mean_var }}), 
      "sd_{{sd_var}}" := sd({{ sd_var }})
    )
}
```

##

## Tidy evaluation - using single variable

* When you want to reference a single variable inside tidyevaluation, double brace `{{ }}` it
* When you reference it you do not have to use it as a string

```r
library(dplyr)
# This function groups by a supplied column and makes a predefined summary
car_summary<-function(var){
  mtcars %>% 
    group_by({{var}}) %>% 
    summarize(mean = mean(mpg),
                          n=n())
}

car_summary(cyl)
```

## Tidy evaluation using multiple variables

* When you want to pass multiple variables you can use the `...`
* this will expand whatever you put there, as variables
* in my example I can use it to pass into the grouping function more than one columns
* this is exactly something I always wanted

```
library(dplyr)
# This function groups by a supplied column and makes a predefined summary
car_summary2<-function(...){
  mtcars %>% 
    group_by(...) %>% 
    summarize(mean = mean(mpg),
                          n=n())
}

car_summary2(cyl,vs)
```

## Tidy evaluation combining single variable and dot dot dot

```
library(dplyr)
# This function groups by a supplied column and enables adding functions to summarize
car_summary3<-function(var,...){
  mtcars %>% 
    group_by({{var}}) %>% 
    summarize(mean = mean(mpg),
              ...,
                          n=n())
}

car_summary3(cyl,hp_mean = mean (hp) )
```

## Using tidy evaluation inside a function

* when I make the function with two variables, the first being `data` I can use it inside a pipe

```
library(dplyr)
# This function summarizes the min and max values on given dataset 
var_summary<-function(data,var){
  data %>% 
    summarize(min = min ( {{var}}),
              max = max ( {{var}}),
                          n=n())
}

mtcars %>% 
  group_by(cyl,vs) %>% 
  var_summary(mpg)
```
