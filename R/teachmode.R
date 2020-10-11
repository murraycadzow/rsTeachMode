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
  if (is.null(rstudioTeachMode_options)){
    message("No rstudioTeachMode options set. Using defaults from `set_teach_mode_settings()`")
    rstudioTeachMode_options <- set_teach_mode_settings()
  }

  # teach -> user
  if (rstudioTeachMode_options$mode == "teach") {
    # select what you want your user settings to be here
    change_font_size(rstudioTeachMode_options$user_font_size) # number has to be integer
    rstudioapi::applyTheme(rstudioTeachMode_options$user_theme_name) # insert name of theme for user here
  } else {# user -> teach
    # select what you want your teaching settings to be
    change_font_size(rstudioTeachMode_options$teach_font_size) # number has to be integer
    rstudioapi::applyTheme(rstudioTeachMode_options$teach_theme_name) # insert name of theme for teaching here
  }

  # flip the mode in the stored options
  rstudioTeachMode_options$mode <- ifelse(rstudioTeachMode_options$mode == "teach", "user", "teach")
  options(rstudioTeachMode = rstudioTeachMode_options)
}





#' Set the options for rstudioTeachMode
#'
#' @param current_mode Either "user" or "teach".
#' @param user_theme_name Name of the theme to be used in "user" mode.
#' @param user_font_size Font size to be used in "user" mode.
#' @param teach_theme_name Name of the theme to be used in "teach" mode.
#' @param teach_font_size Font size to be used in "teach" mode.
#' @param quiet When FALSE prints the code to be added to your Rprofile to make settings persist between sessions.
#'
#' @return List object of the rstudioTeachMode options
#' @export
#'
#' @examples
#' \dontrun{
#' # Use current settings as the "user" mode and use the defaults for "teach" mode.
#' set_teach_mode_settings()
#' }
set_teach_mode_settings <- function(current_mode = "user", user_theme_name = get_current_editor_theme(), user_font_size = get_current_font_size(), teach_theme_name = "Chrome", teach_font_size = 24, quiet = TRUE) {
  rstudioTeachMode_options = list(
    mode = current_mode,
    user_theme_name = user_theme_name,
    user_font_size = user_font_size,
    teach_theme_name = teach_theme_name,
    teach_font_size = teach_font_size
  )

  options(rstudioTeachMode = rstudioTeachMode_options)

  if(!quiet){
    message("To keep your settings between sessions, add the following line to you Rprofile (`usethis::edit_r_profile()`)")
    message(paste0("options(rstudioTeachMode = list(mode = ", "'",rstudioTeachMode_options$mode,"', user_theme_name = '",  rstudioTeachMode_options$user_theme_name,"'", ", user_font_size = ",user_font_size, ", teach_theme_name = '", rstudioTeachMode_options$teach_theme_name, "', teach_font_size = ", rstudioTeachMode_options$teach_font_size, "))"
                ), quote = FALSE)
  }
  invisible(rstudioTeachMode_options)
}
