
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rethnicity

<!-- badges: start -->

[![](https://img.shields.io/badge/doi-10.1016/j.softx.2021.100965-yellow.svg)](https://doi.org/10.1016/j.softx.2021.100965)
[![](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
[![](https://www.r-pkg.org/badges/version/rethnicity?color=green)](https://cran.r-project.org/package=rethnicity)
[![](http://cranlogs.r-pkg.org/badges/grand-total/rethnicity?color=green)](https://cran.r-project.org/package=rethnicity)
[![CRAN
checks](https://badges.cranchecks.info/summary/rethnicity.svg)](https://cran.r-project.org/web/checks/check_results_rethnicity.html)
[![R build
status](https://github.com/fangzhou-xie/rethnicity/workflows/R-CMD-check/badge.svg)](https://github.com/fangzhou-xie/rethnicity/actions)
<!-- badges: end -->

<!-- [![Lifecycle: deprecated](https://img.shields.io/badge/lifecycle-deprecated-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#deprecated) -->

The goal of rethnicity is to provide a method to predict ethnicity from
names of people.

## WARNING!

I created this package hoping to help applied researchers on their
studies regarding ethnic bias and discrimination, and potentially
eliminate the racial and ethnic disparities. By using this package, you
AGREE to the following:

1.  You **understand** that the method cannot make predictions 100%
    correct, and you should be cautious about the results.
2.  You **will NOT** use this package for purposes other than academic
    research.
3.  You **will NOT** disclose the predicted ethnic group to the public,
    given the names data you might have.
4.  You **will NOT** discriminate anyone on the basis of race and color,
    by using the methods provided by this package.
5.  You **will not** use the information to study individuals, but
    rather to study populations in the aggregate.

Again, you should use the package responsibly and please refer to the
[methodology paper](#documentation-on-methodology) for details.

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

## License

[Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International
License](https://creativecommons.org/licenses/by-nc-sa/4.0/).

This license was chosen to prohibit commercial usage, while still being
free and accessible for non-commercial academic uses.
