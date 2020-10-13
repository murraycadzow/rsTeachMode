
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rsTeachMode

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/rsTeachMode)](https://CRAN.R-project.org/package=rsTeachMode)
<!--[![Codecov test coverage](https://codecov.io/gh/murraycadzow/rsTeachMode/branch/main/graph/badge.svg)](https://codecov.io/gh/murraycadzow/rsTeachMode?branch=main) -->
[![R build
status](https://github.com/murraycadzow/rsTeachMode/workflows/R-CMD-check/badge.svg)](https://github.com/murraycadzow/rsTeachMode/actions)

<!-- badges: end -->

The goal of rsTeachMode is to provide an easy mechanism to switch
between theme preferences for personal use and theme preferences for a
teaching environment in RStudio.

**Requires version \>1.3.387 of RStudio**

## No installation option:

Insert the following into your `.Rprofile` which can be opened (if you
have `{usethis}` installed) by using `usethis::edit_r_profile()`

``` r
# Toggle between user rstudio preferences and teaching preferences
# Changes theme and font sizes
# Requires {rstudioapi} to be installed
.toggle <- function(){
  # Assumes you are in user mode if first time running in session
  rsTeachMode_options <- getOption("rsTeachMode")
  if(is.null(rsTeachMode_options)){
    
    # CHANGE SETTINGS HERE ####
    rsTeachMode_options <- list(
      mode = "user", # start in user mode. Options are "user" or "teach"
      user_theme_name = "Solarized Dark", # change to theme name of choice for user
      user_font_size = 12, # change to desired font size
      teach_theme_name = "Chrome", # change to theme name of choice for teaching
      teach_font_size = 24 # change to desired font size
    )
    ###########################
  }
  
  # use the data type currently being used by the system
  if (class(rstudioapi::readPreference("font_size_points", FALSE)) == "integer") {
    rsTeachMode_options$user_font_size <- as.integer(rsTeachMode_options$user_font_size)
    rsTeachMode_options$teach_font_size <- as.integer(rsTeachMode_options$teach_font_size)
  }
  
  # teach -> user
  if (rsTeachMode_options$mode == "teach") {
    rstudioapi::writeRStudioPreference("font_size_points", rsTeachMode_options$user_font_size)
    rstudioapi::applyTheme(rsTeachMode_options$user_theme_name)
  } else {# user -> teach
    rstudioapi::writeRStudioPreference("font_size_points", rsTeachMode_options$teach_font_size)
    rstudioapi::applyTheme(rsTeachMode_options$teach_theme_name)
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
remotes::install_github("murraycadzow/rsTeachMode@main")
```

## Inital setup

This will use your current theme and editor font settings as the ‘user’
options and set your teaching settings to the “Chrome” theme with a font
size of 24. The use of `quite = FALSE` prints out the code to add to
your .Rprofile that is needed to maintain these settings between
sessions.

``` r
library(rsTeachMode)

# keeps your current settings as your 'user' settings and sets preferences for 'teaching' use
set_teach_mode_settings(teach_theme_name = "Chrome", 
                        teach_font_size = 24, 
                        quiet = FALSE)


# Specify all settings
set_teach_mode_settings(current_mode = "user",
                        user_theme_name = "Solarized Light", 
                        user_font_size = 12, 
                        teach_theme_name = "Chrome", 
                        teach_font_size = 24, 
                        quiet = FALSE)
```

Once you have created your set your settings toggle between the two
modes with:

``` r
toggle_teach_mode()
```

Or set it to a keyboard shortcut using the addin.

## RStudio Addins

There are addins as part of this package that make it easy to create
keyboard shortcuts for the common features.

To set a keyboard shortcut, in the Rstudio menu go `Tools -> Modify
Keyboard Shortcuts` and then filter for “Toggle Teach Mode” or one of
the names of the other addins.
