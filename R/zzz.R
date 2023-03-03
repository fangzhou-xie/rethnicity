.onAttach <- function(libname, pkgname) {
  # display the warning message to all users
  
  # this startup message can be suppressed from version 0.2.4
  packageStartupMessage(cli::rule(left = "WARNING!", line = 2))
  packageStartupMessage(
    "The method provided by this package has its limitations ",
    "and anyone must use them cautiously and responsibly. ",
    "You should also agree that you only intend to use the method ",
    "for academic research purpose and not for commercial use. ",
    "You would also agree NOT to discriminate anyone based on ",
    "race or color or any characteristic, ",
    "with the information provided by this package. ",
    "Please refer to the documentation for details: ",
    "https://fangzhou-xie.github.io/rethnicity/index.html"
  )
  packageStartupMessage(cli::rule(line = 2))
  
  invisible()
}

.onUnload <- function(libpath) {
  library.dynam.unload("rethnicity", libpath)
}
