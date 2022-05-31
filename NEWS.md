# rethnicity (0.2.3)
* update dependency on RcppThread >= 2.1.3 to fix the compilation error
* update metadata of package

# rethnicity (0.2.2)
* add `predict_lastname()` and `predict_fullname()` functions as lower-level interfaces
* they also allow for customized models
* add another vignette on how to run inference on the customized models
* change the License from MIT to CC BY-NC-SA 4.0 to prohibit commercial uses
* modify the startup messages to notify users to use the package wisely
* remove docs/ folder, since we are using github actions to automate the process

# rethnicity (0.1.2)
* fix the WARN message from CRAN checks on the vignette

# rethnicity (0.1.1)
* fixed the include path problem and suppressing warning problem
* add `cran-comments.md` into `.Rbuildignore`
* modify the DESCRIPTION file as requested

# rethnicity (0.1.0)
* first submission of the package
* provide `predict_ethnicity()` function to predict the ethnicity from names
