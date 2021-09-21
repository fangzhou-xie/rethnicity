#' Predict ethnicity from names.
#' 
#' @param firstnames A character vector of first names. Default to NULL. Only use this if you are using 'method' = 'fullname'.
#' @param lastnames A character vector of last names. Default to NULL. Use this in both 'fullname' and 'lastname' methods.
#' @param method "fullname" or "lastname". Inference method to choose from.
#' @param threads single integer. Number of threads to use for multi-threading.
#' @param na.rm TRUE or FALSE (boolean). If TRUE, then the NAs will be removed; if FALSE, then return error if there is NA in the arguments.
#' @return data.frame with probability of being each ethnic group and the predicted group (one with highest probability)
#' @examples
#' predict_ethnicity(firstnames = "Alan", lastnames = "Turing")
#' 
#' @export
predict_ethnicity <- function(firstnames = NULL, lastnames = NULL, method = "fullname", threads = 0, na.rm = FALSE) {
  
  # check the number of threads to be used
  if (length(threads) != 1) {
    stop("'threads' argument must be a single value!")
  }
  
  # change the prediction function depends on the modes
  # check the input (length equal and not null)
  if (length(method) != 1) {
    stop("More than 1 'method' provided.")
  }
  if (method == "fullname") {
    if (is.null(firstnames) | is.null(lastnames)) {
      stop("You must provide both 'firstnames' and 'lastnames' arguments!")
    }
    if (length(firstnames) != length(lastnames)) {
      stop("The length of 'firstnames' and 'lastnames' are not equal!")
    }
    if (na.rm) {
      # na.rm = TRUE, remove the NAs
      na_check <- is.na(firstnames) | is.na(lastnames)
      firstnames <- firstnames[!na_check]
      lastnames <- lastnames[!na_check]
    } else {
      # na.rm = FALSE, stop if there is NA
      if (any(is.na(firstnames))) {
        stop("There is NA value in 'firstnames' argument! Remove them first.")
      }
      if (any(is.na(lastnames))) {
        stop("There is NA value in 'lastnames' argument! Remove them first.")
      }
    }
    
    # model_path <- here::here("data-raw/fullname_aligned_distill.json")
    model_path <- system.file("models", "fullname_aligned_distill.json", package = "rethnicity", mustWork = TRUE)
    # df <- predict_ethnicity_fullname(firstnames, lastnames, threads)
    p <- predict_fullname(tolower(firstnames), tolower(lastnames), threads, model_path)
    p <- p / rowSums(p)
    races <- apply(p, 1, which.max)
    race_df <- cbind(firstnames, lastnames, as.data.frame(p), races)
    race_colnames <- c("firstname", "lastname", "prob_asian", "prob_black", "prob_hispanic", "prob_white", "race")
  } else if (method == "lastname") {
    if (is.null(lastnames)) {
      stop("You must provide 'lastnames' argument!")
    }
    if (!is.null(firstnames)) {
      stop("The method is 'lastname' but also provided 'firstnames' argument. Either use 'fullname' method or not using 'firstnames' argument.")
    }
    if (na.rm) {
      na_check <- is.na(lastnames)
      lastnames <- lastnames[!na_check]
    } else {
      if (any(is.na(lastnames))) {
        stop("There is NA value in 'lastnames' argument! Remove them first.")
      }
    }
    
    # model_path <- here::here("data-raw/lastname_distill.json")
    model_path <- system.file("models", "lastname_distill.json", package = "rethnicity", mustWork = TRUE)
    # df <- predict_ethnicity_lastname(lastnames, threads)
    p <- predict_lastname(tolower(lastnames), threads, model_path)
    p <- p / rowSums(p)
    races <- apply(p, 1, which.max)
    race_df <- cbind(lastnames, as.data.frame(p), races)
    race_colnames <- c("lastname", "prob_asian", "prob_black", "prob_hispanic", "prob_white", "race")
  } else {
    stop("The 'method' argument must be either 'fullname' or 'lastname'!")
  }
  
  race_df$races[race_df$races == 1] <- "asian"
  race_df$races[race_df$races == 2] <- "black"
  race_df$races[race_df$races == 3] <- "hispanic"
  race_df$races[race_df$races == 4] <- "white"
  names(race_df) <- race_colnames
  race_df
}
