
inform_startup <- function(msg, ...) {
  
  if (is.null(msg)) return()
  
  rlang::inform(msg, ..., class = "packageStartupMessage")
}

# use cli for the entire startup message
rethnicity_startup_warning_message <- function() {
  d <- cli::cli_div(
    theme = list(
      .emph = list(color = "red", "font-weight" = "bold")
    )
  )
  warn_rule <- cli::rule(
    left = cli::style_bold("WARNING:"), 
    right = cli::format_inline("{.pkg rethnicity}"),
    col = "cyan",
    line = 2
  )
  warns <- paste0(
    cli::col_yellow("!"),
    c(
      " This package predicts race from names, with inherent limitations and bias risks. Use cautiously.",
      " Critically examine methodology and results for biases and ethical implications."
    ),
    collapse = "\n"
  )
  infos <- paste0(
    cli::col_red(cli::symbol$cross),
    c(
      cli::format_inline(
        " Results should not be considered definitive and must ",
        "{.emph NOT} be used for discrimination of any kind."
      ),
      cli::format_inline(
        " Intended for academic research purposes only, ",
        "{.emph NOT} for commercial use."
      )
    ),
    collapse = "\n"
  )
  paste0(warn_rule, "\n", warns, "\n", infos, "\n")
}

rethnicity_startup_info_message <- function() {
  info_rule <- cli::rule(
    left = cli::style_bold("INFO:"), 
    right = cli::format_inline("{.pkg rethnicity}"),
    col = "cyan", line = 2
  )
  
  info_msg <- cli::format_inline(
    cli::col_blue(cli::symbol$info),
    c(
      " For detailed documentation, visit: ",
      "{.href [rethnicity homepage](https://fangzhou-xie.github.io/rethnicity/index.html)} ",
      "and ",
      "{.href [methodology paper](https://www.sciencedirect.com/science/article/pii/S2352711021001874)}."
    )
  )
  
  cite_rule <- cli::rule(
    left = cli::style_bold("CITATION:"), 
    right = cli::format_inline("{.pkg rethnicity}"),
    col = "cyan", line = 2
  )
  
  cite_msg <- cli::format_inline(
    cli::col_blue(cli::symbol$info),
    c(
      " Please use ",
      "{.run [citation(\"rethnicity\")](rethnicity::citation(\"rethnicity\"))} ",
      "to cite my work, thanks!"
    )
  )
  
  paste0(info_rule, "\n", info_msg, "\n\n", cite_rule, "\n", cite_msg, "\n")
}


.onAttach <- function(...) {
  # display the warning message to all users
  
  # this startup message can be suppressed from version 0.2.4
  warn_msg <- rethnicity_startup_warning_message()
  inform_startup(warn_msg)
  
  # additional info msg
  info_msg <- rethnicity_startup_info_message()
  inform_startup(info_msg)
}

.onUnload <- function(libpath) {
  library.dynam.unload("rethnicity", libpath)
}

