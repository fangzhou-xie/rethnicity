
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rethnicity

<!-- badges: start -->

    #> ✓ Setting active project to '/home/xiefangzhou/workspace/gitfolder/rethnicity'

[![](https://www.r-pkg.org/badges/version/rethnicity?color=green)](https://cran.r-project.org/package=rethnicity)
[![](http://cranlogs.r-pkg.org/badges/grand-total/rethnicity?color=green)](https://cran.r-project.org/package=rethnicity)
[![CRAN
checks](https://cranchecks.info/badges/summary/rethnicity)](https://cran.r-project.org/web/checks/check_results_rethnicity.html)
[![](https://img.shields.io/github/last-commit/fangzhou-xie/rethnicity.svg)](https://github.com/fangzhou-xie/rethnicity/commits/main)
[![Build
Status](https://app.travis-ci.com/fangzhou-xie/rethnicity.svg?branch=main)](https://travis-ci.com/github/fangzhou-xie/rethnicity)
[![License:
MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
<!-- badges: end -->

The goal of rethnicity is to provide a method to predict ethnicity from
names of people.

## Installation

<!-- You can install the released version of rethnicity from [CRAN](https://CRAN.R-project.org) with: -->
<!-- ``` r -->
<!-- install.packages("rethnicity") -->
<!-- ``` -->

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("fangzhou-xie/rethnicity")
```

## Getting to use the package in 5 minutes

``` r
library(rethnicity)
#> The method provided by this package has its limitations and anyone must use them cautiously and responsibly.
#> You should also agree that you only intend to use the method for academic research purpose and not for commercial use.
#> You would also agree NOT to discriminate anyone based on race or color or any characteristic, with the information provided by this package.
```

### I want to predict ethnicity from last names!

Sure. I have trained a model to predict and classify race based on last
names. Simply use it as:

``` r
predict_ethnicity(lastnames = "Freeman", method = "lastname")
#>   lastname prob_asian prob_black prob_hispanic prob_white  race
#> 1  Freeman 0.08037726  0.4495561    0.04879313  0.4212735 black
```

### What if I have both first names and last names?

Of course. There is a separate model just to do that. By having both
first names and last names, we can achieve higher accuracy than only
having last names. The syntax is similar to what we have seen from
above.

``` r
predict_ethnicity(firstnames = "Morgan", lastnames = "Freeman", method = "fullname")
#>   firstname lastname prob_asian prob_black prob_hispanic prob_white  race
#> 1    Morgan  Freeman 0.06973174  0.5086463    0.02247369  0.3991482 black
```

### What if I have multiple names?

Cool. I got you covered. Just use vectors as input.

``` r
firstnames <- c("Morgan", "Will")
lastnames <- c("Freeman", "Smith")
predict_ethnicity(lastnames = lastnames, method = "lastname")
#>   lastname prob_asian prob_black prob_hispanic prob_white  race
#> 1  Freeman 0.08037726  0.4495561    0.04879313  0.4212735 black
#> 2    Smith 0.06350436  0.6307345    0.02846091  0.2773002 black
predict_ethnicity(firstnames = firstnames, lastnames = lastnames, method = "fullname")
#>   firstname lastname prob_asian prob_black prob_hispanic prob_white  race
#> 1    Morgan  Freeman 0.06973174  0.5086463   0.022473686 0.39914824 black
#> 2      Will    Smith 0.01116799  0.8902173   0.008021907 0.09059285 black
```

Just remember to have the same length for the `firstnames` and
`lastnames` vectors and the first name and last name for the same person
should have same index in each of the vectors.

### Wait. I want to predict a million names!

Alright. The package also supports extremely fast execution by
multi-threading via the wonderful `RcppThread` package. To use this,
just pass a number to the `threads` argument and the number need to be
greater than 0.

``` r
lastnames <- rep("Freeman", 1000000)
# measure the elapsed time
start_time <- Sys.time()
p <- predict_ethnicity(lastnames = lastnames, method = "lastname", threads = 20)
end_time <- Sys.time()
end_time - start_time
#> Time difference of 9.93066 secs
```

For most use cases that I can imagine, the default setting
(`threads = 0`) should be fast enough since we are leveraging C++
routines for the processing. If you have very large dataset, or if you
have a powerful machine, or if you just want to run the code faster, you
can set the `threads` argument to be bigger than 0 and you should
obeserve performance boost.

Note that I have 24-thread desktop and hence choosing 20 threads to work
on this. You may need to wisely choose the appropriate number of threads
for the job. In general, the more threads you have, the faster it should
run. But the relationship is not linear, as there will be more overhead
when increasing the number of threads.

<!-- ```{r} -->
<!-- lastnames <- rep("Freeman", 1000000) -->
<!-- # measure the elapsed time -->
<!-- start_time <- Sys.time() -->
<!-- p <- predict_ethnicity(lastnames = lastnames, method = "lastname", threads = 10) -->
<!-- end_time <- Sys.time() -->
<!-- end_time - start_time -->
<!-- ``` -->

Processing a million names only spent around 10 seconds for us. I would
call this pretty fast.
