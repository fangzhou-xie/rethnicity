#ifndef STRINGTOID_H
#define STRINGTOID_H

// #include <Rcpp.h>

std::vector<float> string_to_id(std::string s, unsigned int maxlen = 10);
std::vector<float> string_to_id_fullname(std::string string_fn, std::string string_ln);

#endif
