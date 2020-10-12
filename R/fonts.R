#' Change the editor font size
#'
#' Change the font of the editor to be specific size.
#'
#' @param pt The font size (number) in points to change to in the editor.
#'
#' @return
#' @export
#'
#' @examples
#' \dontrun{
#' change_font_size(12)
#' }
change_font_size <- function(pt) {
  if (!is.numeric(pt)) {
    stop("`pt` must be numeric.", call. = FALSE)
  }
  if(pt < 6){
    stop("`pt` must not be smaller than 6.", call. = FALSE)
  }

  rstudioapi::writeRStudioPreference("font_size_points", as.integer(pt))
}


#' Change font size addin
#'
#' An RStudio addin that opens a selector window to choose the font size for the editor.
#' @return
#' @export
#'
#' @examples
#' \dontrun{
#' change_font_size_addin()
#' }
change_font_size_addin <- function() {
  ui <- miniUI::miniPage(
    miniUI::gadgetTitleBar("Select font size"),
    miniUI::miniContentPanel(
      ## Your UI items go here.
      shiny::selectInput(inputId = "font_size", label = "Font size", choices = seq(from = 8, to = 48, by = 2), selected = rstudioapi::readRStudioPreference("font_size_points", FALSE))
    )
  )

  server <- function(input, output, session) {

    ## Your reactive logic goes here.
    font_size <- shiny::reactive(
      as.numeric(input$font_size)
    )
    # Listen for the 'done' event. This event will be fired when a user
    # is finished interacting with your application, and clicks the 'done'
    # button.
    shiny::observeEvent(input$done, {
      change_font_size(font_size())
      # Here is where your Shiny application might now go an affect the
      # contents of a document open in RStudio, using the `rstudioapi` package.
      #
      # At the end, your application should call 'stopApp()' here, to ensure that
      # the gadget is closed after 'done' is clicked.
      shiny::stopApp()
    })
  }

  viewer <- shiny::paneViewer(300)
  shiny::runGadget(ui, server, viewer = viewer)
}

#' Increment current font size
#'
#' @param change Number of points (positive number) to increase the current font size by.
#'
#' @return
#' @export
#'
#' @examples
#' \dontrun{
#' increment_font_size()
#' }
increment_font_size <- function(change = 2) {
  current_font_size <- rstudioapi::readRStudioPreference("font_size_points", FALSE)
  rstudioapi::writeRStudioPreference("font_size_points", as.integer(current_font_size + change))
}


#' Decrement current font size
#'
#' @param change Number of points (positive number) to decrease the current font size by.
#'
#' @return
#' @export
#'
#' @examples
#' \dontrun{
#' decrement_font_size()
#'
#' # decrease current font size by 6
#' decrement_font_size(change = 6)
#' }
decrement_font_size <- function(change = 2) {
  current_font_size <- rstudioapi::readRStudioPreference("font_size_points", FALSE)
  if(current_font_size > 6){
    rstudioapi::writeRStudioPreference("font_size_points", as.integer(current_font_size - change))
  }
}


get_current_font_size <- function() {
  rstudioapi::readRStudioPreference("font_size_points", FALSE)
}
