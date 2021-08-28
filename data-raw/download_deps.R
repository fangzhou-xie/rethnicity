# this code is to automatically update the header files

# get the first dependency header json
system("wget -O include/nlohmann/json.hpp https://raw.githubusercontent.com/nlohmann/json/develop/single_include/nlohmann/json.hpp")

# get the second dependency header fplus
system("wget -O include/fplus/fplus.hpp https://raw.githubusercontent.com/Dobiasd/FunctionalPlus/master/include_all_in_one/include/fplus/fplus.hpp")

# only copy the frugally-deep headers
# system("git clone --depth 1 --filter=blob:none --sparse https://github.com/Dobiasd/frugally-deep")
system("svn export https://github.com/Dobiasd/frugally-deep/trunk/include/fdeep include/fdeep --force")

# system("svn export https://gitlab.com/libeigen/eigen/-/tree/master/Eigen include/Eigen --force")

# this will automatically replace the pure Eigen headers to RcppEigen headers
{
  lines <- readLines("include/fdeep/common.hpp")
  lines[grepl("#include <Eigen/Core>", lines, fixed = TRUE)] <- "#include <RcppEigen.h>"
  writeLines(lines, "include/fdeep/common.hpp")
}

# download the conversion python code
# system("wget -O data-raw/convert_model.py https://raw.githubusercontent.com/Dobiasd/frugally-deep/master/keras_export/convert_model.py")
system("svn export https://github.com/Dobiasd/frugally-deep/trunk/keras_export data-raw/keras_export --force")

# download the model
system("wget -O data-raw/fl_all_ln_lstm.h5 https://github.com/appeler/ethnicolr/raw/master/ethnicolr/models/fl_voter_reg/lstm/fl_all_ln_lstm.h5")
system("wget -O data-raw/fl_all_ln_vocab.csv https://github.com/appeler/ethnicolr/raw/master/ethnicolr/models/fl_voter_reg/lstm/fl_all_ln_vocab.csv")
system("wget -O data-raw/fl_all_name_lstm.h5 https://github.com/appeler/ethnicolr/raw/master/ethnicolr/models/fl_voter_reg/lstm/fl_all_name_lstm.h5")
system("wget -O data-raw/fl_all_name_vocab.csv https://github.com/appeler/ethnicolr/raw/master/ethnicolr/models/fl_voter_reg/lstm/fl_all_name_vocab.csv")

# use the python that has tensorflow installed to do the conversion
system("~/anaconda3/envs/tf/bin/python data-raw/convert_model.py data-raw/fl_all_ln_lstm.h5 data-raw/fl_all_ln_lstm.json")
system("~/anaconda3/envs/tf/bin/python data-raw/convert_model.py data-raw/fl_all_name_lstm.h5 data-raw/fl_all_name_lstm.json")
