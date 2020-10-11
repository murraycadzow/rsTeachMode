
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rsTeachMode

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/rsTeachMode)](https://CRAN.R-project.org/package=rsTeachMode)
<!--[![Codecov test coverage](https://codecov.io/gh/murraycadzow/rsTeachMode/branch/master/graph/badge.svg)](https://codecov.io/gh/murraycadzow/rsTeachMode?branch=master) -->
[![R build
status](https://github.com/murraycadzow/rsTeachMode/workflows/R-CMD-check/badge.svg)](https://github.com/murraycadzow/rsTeachMode/actions)

<!-- badges: end -->

The goal of rsTeachMode is to provide an easy mechanism to switch
between theme preferences for personal use and theme preferences for a
teaching environment in RStudio.

## No installation option:

Insert the following into your `.Rprofile` which can be opened (if you
have `{usethis}` installed) by using `usethis::edit_r_profile()`

``` r
# Toggle between user rstudio preferences and teaching preferences
# Changes theme and font sizes
# Requires {rstudioapi} to be installed
.toggle <- function(){
  # Assumes you are in user mode if first time running in session
  rsTeachMode_options <-  getOption("rstudioTeachMode")
  if (is.null(rsTeachMode_options)) rsTeachMode_options <- list(mode = "user")
  
  # teach -> user
  if (rsTeachMode_options$mode == "teach") {
    # select what you want your user settings to be here
    rstudioapi::writeRStudioPreference("font_size_points", 12L) # number has to be integer
    rstudioapi::applyTheme("Solarized Light") # insert name of theme for user here
  } else {# user -> teach
    # select what you want your teaching settings to be
    rstudioapi::writeRStudioPreference("font_size_points", 24L) # number has to be integer
    rstudioapi::applyTheme("Chrome") # insert name of theme for teaching here
  }
  
  # flip the mode in the stored options
  rsTeachMode_options$mode <- ifelse(rsTeachMode_options$mode == "teach", "user", "teach")
  options(rsTeachMode = rsTeachMode_options)
}
```

Then you can run `.toggle()` when you want to switch between user and
teaching mode.

## Installation

This package is under development and very experimental but can be
installed from github using:

``` r
remotes::install_github("murraycadzow/rsTeachMode")
```

## Inital setup

This will use your current theme and editor font settings as the ‘user’
options and set your teaching settings to the “Chrome” theme with a font
size of 24. The use of `quite = FALSE` prints out the code to add to
your .Rprofile that is needed to maintain these settings between
sessions.

``` r
library(rsTeachMode)

# keeps your current settings as your 'user' settings
set_teach_mode_settings(teach_theme_name = "Chrome", teach_font_size = 24, quiet = FALSE)


# Specify all settings
set_teach_mode_settings(current_mode = "user",user_theme_name = "Solarized Light", user_font_size = 12, teach_theme_name = "Chrome", teach_font_size = 24, quiet = FALSE)
```

## RStudio Addins

There are addins as part of this package that make it easy to create
keyboard shortcuts for the common features.

To set a keyboard shortcut, in the Rstudio menu go `Tools -> Modify
Keyboard Shortcuts` and then filter for “Toggle Teach Mode” or one of
the names of the other addins.
