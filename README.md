
<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- # ```{r, echo = FALSE, results = "hide", message = FALSE} -->
<!-- # suppressMessages(library(badger)) -->
<!-- # ``` -->

# rethnicity

<!-- badges: start -->
<!-- # ```{r, echo = FALSE, results = "asis"} -->
<!-- # cat( -->
<!-- #   badge_cran_release("rethnicity", "green"), -->
<!-- #   badge_cran_download("rethnicity", "grand-total", "green"), -->
<!-- #   badge_cran_checks("rethnicity"), -->
<!-- #   badge_last_commit("fangzhou-xie/rethnicity") -->
<!-- # ) -->
<!-- # ``` -->

[![R-CMD-check](https://github.com/fangzhou-xie/rethnicity/workflows/R-CMD-check/badge.svg)](https://github.com/fangzhou-xie/rethnicity/actions)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/rethnicity)](https://CRAN.R-project.org/package=rethnicity)
[![CRAN_Downloads](http://cranlogs.r-pkg.org/badges/grand-total/rethnicity)](https://CRAN.R-project.org/package=rethnicity)
<!-- [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) -->
<!-- badges: end -->

The goal of rethnicity is to provide a method to predict ethnicity from
names of people.

## WARNING!

I created this package hoping to help applied researchers on their
studies regarding ethnic bias and discrimination, and potentially
eliminate the racial and ethnic disparities. By using this package, you
agree to the following:

1.  You **will NOT** use this package for purposes other than academic
    research.
2.  You **will NOT** disclose the predicted ethnic group to the public,
    given the names data you might have.
3.  You **will NOT** discriminate anyone on the basis of race and color,
    by using the methods provided by this package.
4.  You **understand** that the method cannot make predictions 100%
    correct, and you should be cautious about the results.
    <!-- 4. You **agree** to advocate racial equality. -->

Again, you should use the package responsibly and please refer to the
[methodology paper](#documentation-on-methodology) for details.

## Installation

You can install the released version of rethnicity from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("rethnicity")
```

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("fangzhou-xie/rethnicity")
```

## How to use this package?

There is a
[vignette](https://fangzhou-xie.github.io/rethnicity/articles/introduction.html)
that discusses how to use this package.

## Documentation on Methodology

The complete description of the methodology is on
[arxiv](https://arxiv.org/abs/2109.09228) and please cite it as:

    @article{xie2021,
      title = {Rethnicity: Predicting {{Ethnicity}} from {{Names}}},
      shorttitle = {Predicting {{Ethnicity}} from {{Names}} with Rethnicity},
      author = {Xie, Fangzhou},
      year = {2021},
      month = sep,
      journal = {arXiv:2109.09228 [cs]},
      eprint = {2109.09228},
      eprinttype = {arxiv},
    }

## License

[Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International
License](https://creativecommons.org/licenses/by-nc-sa/4.0/).

This license was chosen to prohibit commercial usage, while still being
free and accessible for non-commercial academic uses.
