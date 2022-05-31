## Update Submission

* Fix r-devel-linux-x86_64-debian-clang installation error
* thanks to Thomas Nagler (https://github.com/fangzhou-xie/rethnicity/pull/6)
* update Description field in the metadata

## Test environments
* local macOS, R 4.1.3
* Github action
* rhub
* win-builder

## R CMD check results
There were no ERRORs or WARNINGs. 

There was 1 NOTE:

* checking installed package size ... NOTE
    installed size is 28.0Mb
    sub-directories of 1Mb or more:
      include   1.9Mb
      libs     24.5Mb
      models    1.6Mb

* The LSTM model is built natively in C++ and the result binary is large.
