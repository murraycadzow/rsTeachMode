test_that("Errors being given", {

  expect_error(change_font_size(4), "`pt` must not be smaller than 6.")
  expect_error(change_font_size("a"), "`pt` must be numeric.")
  expect_error(change_font_size(NA), "`pt` must be numeric.")

  # requires rstudio to be running
  if(rstudioapi::isAvailable()){
  expect_error(increment_font_size("a"), "`change` must be numeric.")
  expect_silent(increment_font_size(0))
  expect_error(increment_font_size(-1), "`change` must be positive.")
  expect_error(decrement_font_size("a"), "`change` must be numeric.")
  expect_silent(decrement_font_size(0))
  expect_error(decrement_font_size(-1), "`change` must be positive.")
  }

})




