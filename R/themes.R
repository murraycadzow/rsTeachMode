#' Get the current rstudio editor theme
#'
#' @return Name of the current rstudio theme being used.
#' @export
#'
#' @examples
#' \dontrun{
#' get_current_editor_theme
#' }
get_current_editor_theme <- function() {
  rstudioapi::getThemeInfo()$editor
}
