// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <RcppEigen.h>
#include <RcppThread.h>
#include <Rcpp.h>

using namespace Rcpp;

#ifdef RCPP_USE_GLOBAL_ROSTREAM
Rcpp::Rostream<true>&  Rcpp::Rcout = Rcpp::Rcpp_cout_get();
Rcpp::Rostream<false>& Rcpp::Rcerr = Rcpp::Rcpp_cerr_get();
#endif

// predict_lastname
Eigen::MatrixXd predict_lastname(std::vector<std::string> strings, int threads, std::string model_path);
RcppExport SEXP _rethnicity_predict_lastname(SEXP stringsSEXP, SEXP threadsSEXP, SEXP model_pathSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< std::vector<std::string> >::type strings(stringsSEXP);
    Rcpp::traits::input_parameter< int >::type threads(threadsSEXP);
    Rcpp::traits::input_parameter< std::string >::type model_path(model_pathSEXP);
    rcpp_result_gen = Rcpp::wrap(predict_lastname(strings, threads, model_path));
    return rcpp_result_gen;
END_RCPP
}
// predict_fullname
Eigen::MatrixXd predict_fullname(std::vector<std::string> strings_fn, std::vector<std::string> strings_ln, int threads, std::string model_path);
RcppExport SEXP _rethnicity_predict_fullname(SEXP strings_fnSEXP, SEXP strings_lnSEXP, SEXP threadsSEXP, SEXP model_pathSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< std::vector<std::string> >::type strings_fn(strings_fnSEXP);
    Rcpp::traits::input_parameter< std::vector<std::string> >::type strings_ln(strings_lnSEXP);
    Rcpp::traits::input_parameter< int >::type threads(threadsSEXP);
    Rcpp::traits::input_parameter< std::string >::type model_path(model_pathSEXP);
    rcpp_result_gen = Rcpp::wrap(predict_fullname(strings_fn, strings_ln, threads, model_path));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_rethnicity_predict_lastname", (DL_FUNC) &_rethnicity_predict_lastname, 3},
    {"_rethnicity_predict_fullname", (DL_FUNC) &_rethnicity_predict_fullname, 4},
    {NULL, NULL, 0}
};

RcppExport void R_init_rethnicity(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}