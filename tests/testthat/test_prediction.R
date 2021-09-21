library(rethnicity)

test_that("no error", {
  expect_equal(nrow(predict_ethnicity(firstnames = "Morgan", lastnames = "Freeman", method = "fullname")), 1)
  expect_equal(nrow(predict_ethnicity(firstnames = "Morgan", lastnames = "Freeman", method = "fullname", threads = 2)), 1)
  expect_equal(nrow(predict_ethnicity(lastnames = "Freeman", method = "lastname")), 1)
  expect_equal(nrow(predict_ethnicity(lastnames = "Freeman", method = "lastname", threads = 2)), 1)
})
