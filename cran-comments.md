## Test environments
* local Fedora 33, R 4.0.5
* Xenial R: oldrel (Travis CI)
* Xenial R: release (Travis CI)
* Xenial R: devel (Travis CI)
* win-builder (devel and release)

## R CMD check results
There were no ERRORs or WARNINGs. 

There was 3 NOTEs:

* checking CRAN incoming feasibility ... NOTE

  This is the initial submission of the package.

* checking top-level files ... NOTE
  
  The `data-raw` folder is to hold some codes and data, which should not be made available to users.
  There are also header-only C++ source codes that should be included under `include` directory.
  Plus this `cran-comments.md` file.

* checking installed package size ... NOTE
  
  The compiled binary is relatively large, since LSTM models are compiled in C++ without linking to Keras or 
  any other dependencies.
