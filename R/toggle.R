
toggle_teach <- function(){
  rstudioTeachMode_options <-  getOption("rstudioTeachMode")
  if (is.null(rstudioTeachMode_options)) rstudioTeachMode_options <- list(mode = "")

  rstudioTeachMode_options$mode <- ifelse(rstudioTeachMode_options$mode == "teach", "user", "teach")
  # teach -> user
  if (rstudioTeachMode_options$mode == "teach") {
    change_font_size(12)
    rstudioapi::applyTheme("Solarized Light {rsthemes}")
  } else {# user -> teach
    change_font_size(24)
    rstudioapi::applyTheme("Chrome")
  }

  # flip mode

  options(rstudioTeachMode = rstudioTeachMode_options)
}


#get_teach_preferences


set_teach_preferences <- function(font_size_pt, theme){
  options(rstudioTeachMode = list(teach_font_size = font_size_pt))
}


#get_user_prefrences
