#' Toggle between user preferences and teaching preferences
#'
#' @return
#' @export
#'
#' @examples
#' \dontrun{
#' toggle_teach_mode()
#' }
toggle_teach_mode <- function(){
  # Assumes you are in user mode if first time running in session
  rstudioTeachMode_options <-  getOption("rstudioTeachMode")
  if (is.null(rstudioTeachMode_options)) rstudioTeachMode_options <- list(mode = "user")

  # teach -> user
  if (rstudioTeachMode_options$mode == "teach") {
    # select what you want your user settings to be here
    change_font_size(12) # number has to be integer
    rstudioapi::applyTheme("Solarized Light") # insert name of theme for user here
  } else {# user -> teach
    # select what you want your teaching settings to be
    change_font_size(24) # number has to be integer
    rstudioapi::applyTheme("Chrome") # insert name of theme for teaching here
  }

  # flip the mode in the stored options
  rstudioTeachMode_options$mode <- ifelse(rstudioTeachMode_options$mode == "teach", "user", "teach")
  options(rstudioTeachMode = rstudioTeachMode_options)
}



