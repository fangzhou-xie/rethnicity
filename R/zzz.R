.onAttach <- function(libname, pkgname) {
  # display the warning message to all users
  packageStartupMessage("###########################################################################################")
  msg <- "The method provided by this package has its limitations and anyone must use them cautiously and responsibly.
You should also agree that you only intend to use the method for academic research purpose and not for commercial use.
You would also agree NOT to discriminate anyone based on race or color or any characteristic, with the information provided by this package."
  packageStartupMessage(msg)
  packageStartupMessage("###########################################################################################")
  
  invisible()
}

.onUnload <- function(libpath) {
  library.dynam.unload("rethnicity", libpath)
}
