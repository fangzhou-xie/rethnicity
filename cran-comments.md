## Update Submission

* add two more functions and other updates
* edit License to: CC BY-NC-SA 4.0

## Test environments
* local Fedora 33, R 4.1.1
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
