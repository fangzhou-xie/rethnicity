## Update Submission

* Fix CRAN note "Check: startup messages can be suppressed"

## Test environments
* local Ubuntu 22.04, R 4.2.2
* Github action
* rhub
* win-builder

## R CMD check results
There were no ERRORs or WARNINGs. 

There was 1 NOTE (as always):

* checking installed package size ... NOTE
    installed size is 24.6Mb
    sub-directories of 1Mb or more:
      include   1.9Mb
      libs     20.9Mb
      models    1.6Mb

* The LSTM model is built natively in C++ and the result binary is large.

* version 0.2.3 CRAN checks also contain the following notes:
* these notes never showed up during my testing though

* 1. Result: NOTE
     Specified C++14: please drop specification unless essential 
* 2. Result: NOTE 
     Problems with news in ‘NEWS.md’:
     No news entries found. 

* C++14 is the requirement for some of the C++ header dependencies
* hence this specification is essential

* NEWS.md file is always updated with each version
