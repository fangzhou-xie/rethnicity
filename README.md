
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

[![R-CMD-check](https://github.com/fangzhou-xie/rethnicity/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/fangzhou-xie/rethnicity/actions/workflows/R-CMD-check.yaml)
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
5.  You **will not** use the information to study individuals, but
    rather to study populations in the aggregate.

Again, you should use the package responsibly and please refer to the
[methodology paper](#documentation-on-methodology) for details.

## Installation

I recommend using the wonderful package manager
[`pak`](https://github.com/r-lib/pak) to install this package:

``` r
# first install `pak` if not yet installed
# install.packages("pak")

# install the CRAN version
pak::pkg_install("rethnicity")

# or install the Github development version
pak::pkg_install("fangzhou-xie/rethnicity")
```

Of course, you can also install the package in the old way: install the
released version of rethnicity from [CRAN](https://CRAN.R-project.org)
with:

``` r
install.packages("rethnicity")
```

Or the development version from [GitHub](https://github.com/) with:

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
[arXiv](https://arxiv.org/abs/2109.09228) and published on
[SoftwareX](https://doi.org/10.1016/j.softx.2021.100965) and please cite
it as:

    @article{xie2022,
      title = {Rethnicity: {{An R}} Package for Predicting Ethnicity from Names},
      shorttitle = {Rethnicity},
      author = {Xie, Fangzhou},
      year = {2022},
      month = jan,
      journal = {SoftwareX},
      volume = {17},
      pages = {100965},
      issn = {2352-7110},
      doi = {10.1016/j.softx.2021.100965},
    }

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
