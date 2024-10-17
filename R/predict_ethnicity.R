

replace_race <- function(races, labels) {
  # check if the 
  sdf <- setdiff(races, as.double(1:length(labels)))
  if (length(sdf) != 0) stop("There are more races predicted than the specified labels! Check the `labels` argument.")
  
  for (i in 1:length(labels)) {
    races[races == i] <- labels[i]
  }
  races
}


#' Predict ethnicity from names.
#' 
#' @description Predict ethnicity either by last names or both first and last names. This is the default and recommended method for prediction.
#' @param firstnames A character vector of first names. Default to NULL. Only use this if you are using 'method' = 'fullname'.
#' @param lastnames A character vector of last names. Default to NULL. Use this in both 'fullname' and 'lastname' methods.
#' @param method "fullname" or "lastname". Inference method to choose from.
#' @param threads single integer. Number of threads to use for multi-threading.
#' @param na.rm TRUE or FALSE (bool). If TRUE, then the NAs will be removed; if FALSE, then return error if there is NA in the arguments.
#' @return data.frame with probability of being each ethnic group and the predicted group (one with highest probability)
#' @examples
#' predict_ethnicity(firstnames = "Alan", lastnames = "Turing")
#' 
#' @export
predict_ethnicity <- function(firstnames = NULL, lastnames = NULL, method = "fullname", threads = 0, na.rm = FALSE) {
  
  # default labels
  labels <- c("asian", "black", "hispanic", "white")
  
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
    if (!(is.character(firstnames) & is.character(lastnames))) {
      stop("Arguments `firstnames` and `lastnames` must be character vectors!")
    }
    if (length(firstnames) != length(lastnames)) {
      stop("The length of 'firstnames' and 'lastnames' are not equal!")
    }
    
    # default fullname model path
    model_path <- system.file("models", "fullname_aligned_distill.json", package = "rethnicity", mustWork = TRUE)
    race_df <- predict_fullname(firstnames, lastnames, na.rm = na.rm, threads = threads, labels = labels, model_path = model_path)
  } else if (method == "lastname") {
    if (is.null(lastnames)) {
      stop("You must provide 'lastnames' argument!")
    }
    if (!is.null(firstnames)) {
      stop("The method is 'lastname' but also provided 'firstnames' argument. Either use 'fullname' method or not using 'firstnames' argument.")
    }
    if (!is.character(lastnames)) {
      stop("Argument `lastnames` must be character vector!")
    }
    if (na.rm) {
      na_check <- is.na(lastnames)
      lastnames <- lastnames[!na_check]
    } else {
      if (any(is.na(lastnames))) {
        stop("There is NA value in 'lastnames' argument! Remove them first.")
      }
    }
    
    # default lastname model path
    model_path <- system.file("models", "lastname_distill.json", package = "rethnicity", mustWork = TRUE)
    race_df <- predict_lastname(lastnames, na.rm = na.rm, threads = threads, labels = labels, model_path = model_path)
  } else {
    stop("The 'method' argument must be either 'fullname' or 'lastname'!")
  }
  
  race_df
}


#' Predict ethnicity from last name
#'
#' @description Predicts ethnicity from last names, using self-trained model with customized labels. 
#' This is designed for advanced users who wish to use their own models. 
#' For most use cases, use [predict_ethnicity()] for prediction.
#' @param lastnames character vector, last names
#' @param na.rm bool, default to FALSE, whether to remove the na in the `lastnames`
#' @param threads int, number of threads for multi-threading
#' @param labels character vector, labels of the classification model, needs to be in the same order as the trained model
#' @param model_path character file path, the path to the trained model in .json format (converted from Keras by frugally-deep)
#' @return data.frame with predicted probability and predicted ethnicity
#' @export
predict_lastname <- function(lastnames, na.rm = FALSE, threads = 0L, labels = NULL, model_path = NULL) {
  
  # if (is.null(labels) && is.null(model_path)) {
  #   # if neither is specified, then use default model
  #   labels <- c("asian", "black", "hispanic", "white")
  #   model_path <- system.file("models", "lastname_distill.json", package = "rethnicity", mustWork = TRUE)
  # } else if (is.null(labels) + is.null(model_path) == 1) {
  #   stop("Neither or both 'labels' and 'model_path' must be supplied!")
  # } else {
  #   # if both supplied, check
  #   if (!file.exists(model_path)) stop("Model file does not exist!")
  #   if (tools::file_ext(model_path) != "json") stop("Model is not in json format!")
  # }
  if (is.null(labels)) stop("`labels` must be provided!")
  if (is.null(model_path)) stop("`model_path` must be provided!")
  if (!file.exists(model_path)) stop("Model file does not exist!")
  if (tools::file_ext(model_path) != "json") stop("Model is not in json format!")
  # need to check the missing entries
  if (na.rm) {
    lastnames <- lastnames[!is.na(lastnames)]
  } else {
    if (any(is.na(lastnames))) {
      stop("There is NA value in 'lastnames' argument! Use `na.rm = TRUE` in the function!")
    }
  }
  
  # return probability matrix
  pmat <- predict_lastname_cpp(tolower(lastnames), threads, model_path)
  pmat <- pmat / rowSums(pmat)
  races <- apply(pmat, 1, which.max)
  # TODO: replace this races
  races <- replace_race(races, labels)
  race_df <- cbind(lastnames, as.data.frame(pmat), races)
  race_colnames <- c("lastname", paste("prob_", labels, sep = ""), "race")
  names(race_df) <- race_colnames
  
  race_df # return data.frame
}


#' Predict ethnicity from full name
#'
#' @description Predicts ethnicity from first names and last names, using self-trained model with customized labels.
#' This is designed for advanced users who wish to use their own models. 
#' For most use cases, use [predict_ethnicity()] for prediction.
#' @param firstnames character vector, first names
#' @param lastnames character vector, last names
#' @param na.rm bool, default to FALSE, whether to remove the na in the `lastnames`
#' @param threads int, number of threads for multi-threading
#' @param labels character vector, labels of the classification model, needs to be in the same order as the trained model
#' @param model_path character file path, the path to the trained model in .json format (converted from Keras by frugally-deep)
#' @return data.frame with predicted probability and predicted ethnicity
#' @export
predict_fullname <- function(firstnames, lastnames, na.rm = FALSE, threads = 0L, labels = NULL, model_path = NULL) {
  
  if (is.null(labels)) stop("`labels` must be provided!")
  if (is.null(model_path)) stop("`model_path` must be provided!")
  if (!file.exists(model_path)) stop("Model file does not exist!")
  if (tools::file_ext(model_path) != "json") stop("Model is not in json format!")
  # need to check the missing entries
  if (na.rm) {
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
  
  # return probability matrix
  pmat <- predict_fullname_cpp(tolower(firstnames), tolower(lastnames), threads, model_path)
  pmat <- pmat / rowSums(pmat)
  races <- apply(pmat, 1, which.max)
  # TODO: replace this races
  races <- replace_race(races, labels)
  race_df <- cbind(firstnames, lastnames, as.data.frame(pmat), races)
  race_colnames <- c("firstname", "lastname", paste("prob_", labels, sep = ""), "race")
  names(race_df) <- race_colnames
  
  race_df # return data.frame
}



# # test function
# 
# predict_test <- function(ln) {
#   model_path <- system.file("models", "lastname_distill.json", package = "rethnicity", mustWork = TRUE)
#   predict_test_cpp(ln, model_path)
# }
# 
# 
# 
# predict_test <- rethnicity:::predict_test
# 
# predict_test("Turing")
