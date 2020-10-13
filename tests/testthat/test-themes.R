test_that("Errors given", {
  expect_error(set_teach_mode_settings(current_mode = ""), "`current_mode` must be either 'user' or 'teach'.")
  expect_error(set_teach_mode_settings(current_mode = 2), "`current_mode` must be either 'user' or 'teach'.")
  expect_error(set_teach_mode_settings(current_mode = NA), "`current_mode` must be either 'user' or 'teach'.")
})
