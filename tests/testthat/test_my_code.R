library(nasaR)
## Because of limited time, I could not make test cases for every function & situation. However,
## I would make the test cases complete later then.

test_that("output should be a data frame", {
  expect_is(Neo_Feed(start_date = as.Date("2019-11-01"), end_date = as.Date("2019-11-03"), as_dataframe = TRUE), "data.frame")
  expect_is(Insight(simplified_data_frame = TRUE), "data.frame")
})

test_that("output should be a list", {
  expect_is(NHATS(mode = "O", des = "99942"), "list")
  expect_is(Techport(update_since = as.Date("2016-01-01")), "list")
})
