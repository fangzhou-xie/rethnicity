## Resubmission

This is a resubmission. In this version, I have:

* put the `include` folder under `inst` folder, as is the usual practice
* also commented out the warning-suppressing pragmas in the source header files
* add `cran-comments.md` into `.Rbuildignore`

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

* checking CRAN incoming feasibility ... NOTE

  This is the initial submission of the package.
