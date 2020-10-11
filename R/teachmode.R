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
  rsTeachMode_options <-  getOption("rsTeachMode")
  if (is.null(rsTeachMode_options)){
    message("No rsTeachMode options set. Using defaults from `set_teach_mode_settings()`")
    rsTeachMode_options <- set_teach_mode_settings()
  }

  # teach -> user
  if (rsTeachMode_options$mode == "teach") {
    # select what you want your user settings to be here
    change_font_size(rsTeachMode_options$user_font_size) # number has to be integer
    rstudioapi::applyTheme(rsTeachMode_options$user_theme_name) # insert name of theme for user here
  } else {# user -> teach
    # select what you want your teaching settings to be
    change_font_size(rsTeachMode_options$teach_font_size) # number has to be integer
    rstudioapi::applyTheme(rsTeachMode_options$teach_theme_name) # insert name of theme for teaching here
  }

  # flip the mode in the stored options
  rsTeachMode_options$mode <- ifelse(rsTeachMode_options$mode == "teach", "user", "teach")
  options(rsTeachMode = rsTeachMode_options)
}





#' Set the options for rsTeachMode
#'
#' @param current_mode Either "user" or "teach".
#' @param user_theme_name Name of the theme to be used in "user" mode.
#' @param user_font_size Font size to be used in "user" mode.
#' @param teach_theme_name Name of the theme to be used in "teach" mode.
#' @param teach_font_size Font size to be used in "teach" mode.
#' @param quiet When FALSE prints the code to be added to your Rprofile to make settings persist between sessions.
#'
#' @return List object of the rsTeachMode options
#' @export
#'
#' @examples
#' \dontrun{
#' # Use current settings as the "user" mode and use the defaults for "teach" mode.
#' set_teach_mode_settings()
#' }
set_teach_mode_settings <- function(current_mode = "user", user_theme_name = get_current_editor_theme(), user_font_size = get_current_font_size(), teach_theme_name = "Chrome", teach_font_size = 24, quiet = TRUE) {
  if(!current_mode %in% c("user", "teach")){
    stop("`current_mode` must be either 'user' or 'teach'.")
  }
  if(!user_theme_name %in% vapply(rstudioapi::getThemes(), `[[`, "name", FUN.VALUE =character(1))){
    stop(paste0("Specified `user_theme_name` of '", user_theme_name, "' is not an installed theme."), call. = FALSE)
  }
  if(!teach_theme_name %in% vapply(rstudioapi::getThemes(), `[[`, "name", FUN.VALUE =character(1))){
    stop(paste0("Specified `teach_theme_name` of '", teach_theme_name, "' is not an installed theme."), call. = FALSE)
  }
  if(!is.numeric(user_font_size)){
    stop("Specified `user_font_size` must be of type 'numeric'.", call. = FALSE)
  }
  if(!is.numeric(teach_font_size)){
    stop("Specified `teach_font_size` must be of type 'numeric'.", call. = FALSE)
  }


  rsTeachMode_options = list(
    mode = current_mode,
    user_theme_name = user_theme_name,
    user_font_size = user_font_size,
    teach_theme_name = teach_theme_name,
    teach_font_size = teach_font_size
  )

  options(rsTeachMode = rsTeachMode_options)

  if(!quiet){
    message("To keep your settings between sessions, add the following line to you .Rprofile (`usethis::edit_r_profile()`)")
    message(paste0("options(rsTeachMode = list(mode = ", "'",rsTeachMode_options$mode,"', user_theme_name = '",  rsTeachMode_options$user_theme_name,"'", ", user_font_size = ",user_font_size, ", teach_theme_name = '", rsTeachMode_options$teach_theme_name, "', teach_font_size = ", rsTeachMode_options$teach_font_size, "))"
                ))
  }
  invisible(rsTeachMode_options)
}
