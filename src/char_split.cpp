// #include <string.h>
#include <Rcpp.h>
using namespace Rcpp;

#include <RcppThread.h>

// [[Rcpp::plugins(cpp11)]]
// [[Rcpp::depends(RcppThread)]]

// [[Rcpp::export]]
std::vector<std::string> char_split(std::string s, int n = 2) {
  // init output vector
  std::vector<std::string> t(s.size()-n+1);
  for (int i = 0; i < int(s.size())-n+1; i++) {
    std::string tempstr(1, s[i]);
    for (int j = 1; j <= n-1; j++) {
      tempstr += s[i+j];
    }
    t[i] = tempstr;
  }
  
  return(t);
}

// // [[Rcpp::export]]
// std::vector<std::string> char_split_parallel(std::string s, int ngram = 2, int threads = 0) {
//   // init output vector
//   std::vector<std::string> t(s.size()-ngram+1);
//   // init the thread pool
//   RcppThread::ThreadPool pool(threads);
//   pool.parallelFor(0, t.size(), [&] (unsigned int i) {
//     std::string tempstr(1, s[i]);
//     for (int j = 1; j <= ngram-1; j++) {
//       tempstr += s[i+j];
//     }
//     t[i] = tempstr;
//   });
//   return(t);
// }

// [[Rcpp::export]]
std::vector<int> test_parallel(int n) {
  RcppThread::ThreadPool pool(n);
  std::vector<int> x(10);
  pool.parallelFor(0, x.size(), [&x] (unsigned int i) {
    std::this_thread::sleep_for(std::chrono::seconds(1));
    x[i] = i;
  });
  return(x);
}

// [[Rcpp::export]]
std::vector<std::vector<std::string>> char_split_parallel(std::vector<std::string> strings, int ngram = 2, int threads = 0) {
  RcppThread::ThreadPool pool(threads);
  std::vector<std::vector<std::string>> x(strings.size());
  pool.parallelFor(0, x.size(), [&] (unsigned int i) {
    x[i] = char_split(strings[i], 2);
  });
  return(x);
}
