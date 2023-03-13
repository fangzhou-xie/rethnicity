## Update Submission

* Fix CRAN note "Check: startup messages can be suppressed"
* remove C++14 spec

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

