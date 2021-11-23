#ifndef RETHNICITY_STRINGTOID_H
#define RETHNICITY_STRINGTOID_H

#include <Rcpp.h>

inline std::vector<float> string_to_id(std::string s, unsigned int maxlen = 10) {
  std::vector<char> chars = {'E','a','b','c','d','e','f','g','h','i','j','k','l','m','n',
                             'o','p','q','r','s','t','u','v','w','x','y','z',' ','U'};
  std::vector<float> id_vec(maxlen, static_cast<float>(0));
  for (unsigned i = 0; i < s.size(); ++i) {
    // break if the number of characters in string is longer than maxlen
    if (i == maxlen) {
      break;
    }
    char c = s[i];
    auto it = find(chars.begin(), chars.end(), c);
    // TODO: add puncts support (puncts all map to space)
    int id;
    if (it != chars.end()) {
      id = (std::ispunct(c)) ? 27 : it - chars.begin();
    } else {
      id = 28; // pad to 0 but unknown to 27
    }
    id_vec[i] = static_cast<float>(id);
    // std::cout << id << ' ';
  }
  // std::cout << std::endl;
  return(id_vec);
}

inline std::vector<float> string_to_id_fullname(std::string string_fn, std::string string_ln) {
  // for the fullname processing, we need to process firstname and lastname separately and then combine
  // their id vec together
  std::vector<float> vec_fn = string_to_id(string_fn);
  std::vector<float> vec_ln = string_to_id(string_ln);
  for (std::size_t i = 0; i < vec_ln.size(); i++) {
    vec_fn.push_back(vec_ln[i]);
  }
  // vec_fn.insert(vec_fn.end(), vec_ln.start(), vec_ln.end());
  return(vec_fn);
}

#endif // RETHNICITY_STRINGTOID_H
