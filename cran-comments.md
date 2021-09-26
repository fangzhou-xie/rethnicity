## Update Submission

* fix the WARNs by CRAN checks on the vignette building process

## Test environments
* local Fedora 33, R 4.0.5
* Xenial R: oldrel (Travis CI)
* Xenial R: release (Travis CI)
* Xenial R: devel (Travis CI)
* win-builder (devel and release)
* Solaris, macOS High Sierra, Windows-x86_64-devel (rhub)

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
