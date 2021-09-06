## Resubmission

This is a resubmission. In this version, I have:

* put the `include` folder under `inst` folder, as is the usual practice

* also commented out the warning-suppressing pragmas in the source header files

## Test environments
* local Fedora 33, R 4.0.5
* Xenial R: oldrel (Travis CI)
* Xenial R: release (Travis CI)
* Xenial R: devel (Travis CI)
* win-builder (devel and release)
* Solaris, macOS High Sierra, Windows-x86_64-devel (rhub)

## R CMD check results
There were no ERRORs or WARNINGs. 

There were 3 NOTEs:

* checking CRAN incoming feasibility ... NOTE

  This is the initial submission of the package.

* checking top-level files ... NOTE
  
  'cran-comments.md' file for submission to CRAN.

* checking installed package size ... NOTE
  
  The compiled binary is relatively large, since LSTM models are compiled in C++ without linking to Keras or 
  any other dependencies.

