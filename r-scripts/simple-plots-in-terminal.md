---
description: How to make fast iterating workflow from the commandline
---

# Simple plots in terminal



## Resources

[txtplot package from cran](https://cran.r-project.org/web/packages/txtplot/)\\

## Example

```
a<-seq(1,10)
b<-a*a
txtplot(a,b)
```

## Calculating statistical power of test

### Motivation

Be able to design a clinical study or be sure about the amount of the experiment

### Resources

[link to pwr pacakage vignette on CRAN](https://cran.r-project.org/web/packages/pwr/vignettes/pwr-vignette.html)\
[link to stack overflow and MESS package](https://stackoverflow.com/questions/51374972/statistical-power-and-sample-size-determination-for-two-sample-unequal-variance)\
[list of resources to design clinical studies from CRAN](https://cran.r-project.org/web/views/ClinicalTrials.html)\\

### Examples

#### How to tell if a coin is faked

Let's say we suspect we have a loaded coin that lands heads 75% of the time instead of the expected 50%. We wish to create an experiment to test this. We will flip the coin a certain number of times and observe the proportion of heads. We will then conduct a one-sample proportion test to see if the proportion of heads is significantly different from what we would expect with a fair coin. We will judge significance by our p-value. If our p-value falls below a certain threshold, say 0.05, we will conclude our coin's behavior is inconsistent with that of a fair coin.

Our null hypothesis is that the coin is fair and lands heads 50% of the time ((\pi) = 0.50). Our alternative hypothesis is that the coin is loaded to land heads more then 50% of the time ((\pi) > 0.50). How many times should we flip the coin to have a high probability (or power), say 0.80, of correctly rejecting the null of (\pi) = 0.5 if our coin is indeed loaded to land heads 75% of the time?

```
#saved as power01.R
#run it by Rscript power01.R

library(pwr)

pwr.p.test(h = ES.h(p1 = 0.75, p2 = 0.50),
           sig.level = 0.05,
           power = 0.80,
           alternative = "greater")
```

Short explanation about the parameters:

1. sig. level = type one error. The risk we say there is a difference where there is not. Usually 0.05 or less, need to be more strict on this.
2. power = type two error. The risk of not realizing there is a difference when there is. Usually no less then 80%.
3. alternative "greater" is one sided, in case we do not know the direction, should use the two sided.

#### Plotting the sample size and power

```
# to plot the graph of sample size and power
# saved as power_plot.R
library(pwr)
library(txtplot)
p.out <- pwr.p.test(h = ES.h(p1 = 0.75, p2 = 0.50),
                    sig.level = 0.05,
                    power = 0.80,
                    alternative = "greater")
plot(p.out)
```

This does not work for plotting with txtplot(), need to test this in RStudio.\
But it works in the Rstudio like a magic, seems to be a super interesting tool to use for various explorations.\
