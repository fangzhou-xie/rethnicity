## Test environments
* local Fedora 33, R 4.0.5
* Xenial R: oldrel (Travis CI)
* Xenial R: release (Travis CI)
* Xenial R: devel (Travis CI)
* win-builder (devel and release)

## R CMD check results
There were no ERRORs or WARNINGs. 

There was 1 NOTE:

* This is the initial submission of the package.
* checking dependencies in R code ... NOTE
  Namespace in Imports field not imported from: 'R6'

  R6 is a build-time dependency.

