## Update Submission

* fix the clang 19/20 warnings by updating the dependency json library

## Test environments
* local Ubuntu 22.04, R 4.4.3
* Github action (ubuntu-latest, windows-latest, macos-latest)
* rhub (clang20)
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
* Also, this package will only receive critical maintenance from now on.

## reverse dep check results (github actions)

* no issue found for both the old package and the new package
