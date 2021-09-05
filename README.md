
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rethnicity

<!-- badges: start -->
<!-- badges: end -->

The goal of rethnicity is to …

## Installation

You can install the released version of rethnicity from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("rethnicity")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("fangzhou-xie/rethnicity")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(rethnicity)
#> The method provided by this package has its limitations and anyone must use them cautiously and responsibly.
#> You should also agree that you only intend to use the method for academic research purpose and not for commercial use.
#> You would also agree NOT to discriminate anyone based on race or color or any characteristic, with the information provided by this package.
## basic example code
```

What is special about using `README.Rmd` instead of just `README.md`?
You can include R chunks like so:

``` r
summary(cars)
#>      speed           dist       
#>  Min.   : 4.0   Min.   :  2.00  
#>  1st Qu.:12.0   1st Qu.: 26.00  
#>  Median :15.0   Median : 36.00  
#>  Mean   :15.4   Mean   : 42.98  
#>  3rd Qu.:19.0   3rd Qu.: 56.00  
#>  Max.   :25.0   Max.   :120.00
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this. You could also
use GitHub Actions to re-render `README.Rmd` every time you push. An
example workflow can be found here:
<a href="https://github.com/r-lib/actions/tree/master/examples" class="uri">https://github.com/r-lib/actions/tree/master/examples</a>.

You can also embed plots, for example:

<img src="man/figures/README-pressure-1.png" width="100%" />

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub and CRAN.
