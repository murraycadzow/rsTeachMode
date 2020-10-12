test_that("multiplication works", {
  expect_equal(2 * 2, 4)

  # font.R errors
  expect_error(change_font_size(4), "`pt` must not be smaller than 6.")
  expect_error(change_font_size("a"), "`pt` must be numeric.")
  expect_error(change_font_size(NA), "`pt` must be numeric.")

  # teachmode.R errors
  expect_error(set_teach_mode_settings(current_mode = ""), "`current_mode` must be either 'user' or 'teach'.")
  expect_error(set_teach_mode_settings(current_mode = 2), "`current_mode` must be either 'user' or 'teach'.")
  expect_error(set_teach_mode_settings(current_mode = NA), "`current_mode` must be either 'user' or 'teach'.")

})
