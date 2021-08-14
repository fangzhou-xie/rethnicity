#include <Rcpp.h>
using namespace Rcpp;

#include <fdeep/fdeep.hpp>

// [[Rcpp::export]]
int test_cpp(std::string model_path) {
  const auto model = fdeep::load_model(model_path);
  const auto result = model.predict(
  {fdeep::tensor(fdeep::tensor_shape(static_cast<std::size_t>(4)),
                 std::vector<float>{1, 2, 3, 4})});
  std::cout << fdeep::show_tensors(result) << std::endl;
  return 0;
}


// [[Rcpp::export]]
int test_lastname(std::string model_path) {
  const auto model = fdeep::load_model(model_path);
  const auto result = model.predict(
  {fdeep::tensor(fdeep::tensor_shape(static_cast<std::size_t>(4)),
                 std::vector<int>{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20})}
  );
  std::cout << fdeep::show_tensors(result) << std::endl;
}
