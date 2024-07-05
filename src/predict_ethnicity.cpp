
#include <Rcpp.h>
#include <RcppEigen.h>
#include <RcppThread.h>

using namespace Rcpp;

#include <fdeep/fdeep.hpp>
#include "string_to_id.h"


// // [[Rcpp::export()]]
// int predict_test_cpp(std::string strings, std::string model_path) {
//   std::vector<double> result;
//   
//   auto model = fdeep::load_model(model_path, false, fdeep::dev_null_logger);
//   
//   return 0;
// }

// [[Rcpp::export(name = "predict_lastname_cpp")]]
Eigen::MatrixXd predict_lastname(std::vector<std::string> strings, int threads, std::string model_path) {
  // init float vector
  std::vector<std::vector<double>> results(strings.size());
  
  // std::string model_path = "data-raw/lastname_distill.json";
  
  auto model = fdeep::load_model(model_path, false, fdeep::dev_null_logger);
  
  // init the thread pool
  RcppThread::ThreadPool pool(threads);
  
  pool.parallelFor(0, strings.size(), [&] (unsigned int i) {
    std::string string = strings[i];
    
    std::vector<float> string_ids = string_to_id(string, 10);
    fdeep::tensor tensor(fdeep::tensor_shape(static_cast<std::size_t>(string_ids.size())), string_ids);
    
    // make the inference
    auto result_tensor = model.predict({tensor});
    std::vector<float> result_vec = result_tensor[0].to_vector();
    std::vector<double> result_double(result_vec.begin(), result_vec.end());
    
    results[i] = result_double;
    
    RcppThread::checkUserInterrupt();
  });
  
  // IMPORTANT: join the pool to wait for all threads to complete before return
  pool.join();
  
  // conver to Eigen matrix
  Eigen::MatrixXd mat(static_cast<int>(strings.size()), 4);
  for (int i = 0; i < static_cast<int>(strings.size()); i++) {
    Eigen::VectorXd v = Eigen::Map<Eigen::VectorXd, Eigen::Unaligned>(results[i].data(), results[i].size());
    mat.row(i) = v;
  }
  
  return(mat);
}

// [[Rcpp::export(name = "predict_fullname_cpp")]]
Eigen::MatrixXd predict_fullname(std::vector<std::string> strings_fn, std::vector<std::string> strings_ln, int threads, std::string model_path) {
  // init float vector
  std::vector<std::vector<double>> results(strings_fn.size());
  
  // std::string model_path = "data-raw/fullname_aligned_distill.json";
  
  auto model = fdeep::load_model(model_path, false, fdeep::dev_null_logger);
  
  // init the thread pool
  RcppThread::ThreadPool pool(threads);
  
  pool.parallelFor(0, strings_fn.size(), [&] (unsigned int i) {
    const std::string string_fn = strings_fn[i];
    const std::string string_ln = strings_ln[i];
    
    const std::vector<float> string_ids = string_to_id_fullname(string_fn, string_ln);
    fdeep::tensor tensor(fdeep::tensor_shape(static_cast<std::size_t>(string_ids.size())), string_ids);
    
    // make the inference
    auto result_tensor = model.predict({tensor});
    const std::vector<float> result_vec = result_tensor[0].to_vector();
    const std::vector<double> result_double(result_vec.begin(), result_vec.end());
    
    results[i] = result_double;
    
    RcppThread::checkUserInterrupt();
  });
  
  // IMPORTANT: join the pool to wait for all threads to complete before return
  pool.join();
  
  // conver to Eigen matrix
  Eigen::MatrixXd mat(static_cast<int>(strings_fn.size()), 4);
  for (int i = 0; i < static_cast<int>(strings_fn.size()); i++) {
    Eigen::VectorXd v = Eigen::Map<Eigen::VectorXd, Eigen::Unaligned>(results[i].data(), results[i].size());
    mat.row(i) = v;
  }
  
  return(mat);
}
