library(rethnicity)

test_that("no error", {
  expect_equal(nrow(predict_ethnicity(firstnames = "Morgan", lastnames = "Freeman", method = "fullname")), 1)
  expect_equal(nrow(predict_ethnicity(firstnames = "Morgan", lastnames = "Freeman", method = "fullname", threads = 2)), 1)
  expect_equal(nrow(predict_ethnicity(lastnames = "Freeman", method = "lastname")), 1)
  expect_equal(nrow(predict_ethnicity(lastnames = "Freeman", method = "lastname", threads = 2)), 1)
})

test_that("lastname wrapper", {
  expect_equal(
    predict_ethnicity(lastnames = "Sameulson", method = "lastname"), 
    predict_lastname("Sameulson", labels = c("asian", "black", "hispanic", "white"), 
                     model_path = system.file("models", "lastname_distill.json", package = "rethnicity", mustWork = TRUE))
  )
})

test_that("fullname wrapper", {
  expect_equal(
    predict_ethnicity(firstnames = "Morgan", lastnames = "Freeman", method = "fullname"),
    predict_fullname(firstnames = "Morgan", lastnames = "Freeman",
                     labels = c("asian", "black", "hispanic", "white"),
                     model_path = system.file("models", "fullname_aligned_distill.json", package = "rethnicity", mustWork = TRUE))
  )
})
