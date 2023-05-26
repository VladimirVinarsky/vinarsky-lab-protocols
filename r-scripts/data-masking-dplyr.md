---
description: >-
  Get the possibility to use vectors of names to select, group, and summarize
  datasets
---

# Data masking dplyr

## Motivation&#x20;

## Resources

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
