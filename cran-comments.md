## Update Submission

* update arxiv doi
* Fix CRAN "warning: template-id not allowed for constructor in C++20"
* add C++17 spec (to remove the warning for now)
* a new package is under construction to replace this one eventually

## Test environments
* local Ubuntu 22.04, R 4.4.1
* Github action
* rhub
* win-builder

## R CMD check results
There were no ERRORs or WARNINGs. 

There was 1 NOTE (as always):

* checking installed package size ... NOTE
    installed size is 28.5Mb
    sub-directories of 1Mb or more:
      include   1.9Mb
      libs     24.9Mb
      models    1.6Mb

* The LSTM model is built natively in C++ and the result binary is large.

