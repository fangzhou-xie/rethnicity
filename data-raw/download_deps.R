# this code is to automatically update the header files

################################################################################################
# 1. download dependencies
################################################################################################

# get the first dependency header json
system("wget -O inst/include/nlohmann/json.hpp https://raw.githubusercontent.com/nlohmann/json/develop/single_include/nlohmann/json.hpp")

# get the second dependency header fplus
system("wget -O inst/include/fplus/fplus.hpp https://raw.githubusercontent.com/Dobiasd/FunctionalPlus/master/include_all_in_one/include/fplus/fplus.hpp")

# only copy the frugally-deep headers
system("git clone --depth 1 --filter=blob:none --sparse https://github.com/Dobiasd/frugally-deep")
# Github removed svn support
# system("svn export https://github.com/Dobiasd/frugally-deep/trunk/include/fdeep inst/include/fdeep --force")

# system("svn export https://gitlab.com/libeigen/eigen/-/tree/master/Eigen include/Eigen --force")
# download the keras export python code itself
system("wget -O data-raw/convert_model.py https://raw.githubusercontent.com/Dobiasd/frugally-deep/master/keras_export/convert_model.py")


################################################################################################
# 2. automatic the process of edit the codes suited to be wrapped for R package
################################################################################################

# this will automatically replace the pure Eigen headers to RcppEigen headers
{
  lines <- readLines("inst/include/fdeep/common.hpp")
  lines[grepl("#include <Eigen/Core>", lines, fixed = TRUE)] <- "#include <RcppEigen.h>"
  writeLines(lines, "inst/include/fdeep/common.hpp")
}

# comment out the suppression of warnings
# TODO: loop all the files with the same suppressing problem
# {
#   lines <- readLines("inst/include/nlohmann/json.hpp")
#   lines <- unlist(Map(function(x) ifelse(grepl("#pragma GCC diagnostic", x, fixed = TRUE), paste("//", x, collapse = ""), x), 
#                       lines), F, F)
#   lines <- unlist(Map(function(x) ifelse(grepl("#pragma clang diagnostic", x, fixed = TRUE), paste("//", x, collapse = ""), x), 
#                       lines), F, F)
#   writeLines(lines, "inst/include/nlohmann/json.hpp")
# }

(
  function() {
    files <- c("fdeep/common.hpp", "fdeep/import_model.hpp", "fplus/fplus.hpp", "nlohmann/json.hpp")
    for (file in files) {
      lines <- readLines(paste0("inst/include/", file))
      lines <- unlist(Map(function(x) ifelse(grepl("#pragma GCC diagnostic", x, fixed = TRUE), paste("//", x, collapse = ""), x), 
                          lines), FALSE, FALSE)
      lines <- unlist(Map(function(x) ifelse(grepl("#pragma clang diagnostic", x, fixed = TRUE), paste("//", x, collapse = ""), x), 
                          lines), FALSE, FALSE)
      writeLines(lines, paste0("inst/include/", file))
    }
  }
)()


# # download the conversion python code
# # system("wget -O data-raw/convert_model.py https://raw.githubusercontent.com/Dobiasd/frugally-deep/master/keras_export/convert_model.py")
# system("svn export https://github.com/Dobiasd/frugally-deep/trunk/keras_export data-raw/keras_export --force")
# 
# # download the model
# system("wget -O data-raw/fl_all_ln_lstm.h5 https://github.com/appeler/ethnicolr/raw/master/ethnicolr/models/fl_voter_reg/lstm/fl_all_ln_lstm.h5")
# system("wget -O data-raw/fl_all_ln_vocab.csv https://github.com/appeler/ethnicolr/raw/master/ethnicolr/models/fl_voter_reg/lstm/fl_all_ln_vocab.csv")
# system("wget -O data-raw/fl_all_name_lstm.h5 https://github.com/appeler/ethnicolr/raw/master/ethnicolr/models/fl_voter_reg/lstm/fl_all_name_lstm.h5")
# system("wget -O data-raw/fl_all_name_vocab.csv https://github.com/appeler/ethnicolr/raw/master/ethnicolr/models/fl_voter_reg/lstm/fl_all_name_vocab.csv")
# 
# # use the python that has tensorflow installed to do the conversion
# system("~/anaconda3/envs/tf/bin/python data-raw/convert_model.py data-raw/fl_all_ln_lstm.h5 data-raw/fl_all_ln_lstm.json")
# system("~/anaconda3/envs/tf/bin/python data-raw/convert_model.py data-raw/fl_all_name_lstm.h5 data-raw/fl_all_name_lstm.json")
