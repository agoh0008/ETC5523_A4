#' @name run_app
#' @title Run U.S. College Majors Shiny Application
#'
#' @description
#' This function launches a Shiny application that provides interactive visualizations
#' and analysis tools for U.S. college majors data (2010-2012).
#'
#' @details
#' The function locates the Shiny application directory within the "gradmajors" package and launches the application.
#'
#' @return
#' The Shiny application is launched in the default web browser.
#'
#' @export

run_app <- function() {
  app_dir <- system.file("myapp", package = "gradmajors")
  shiny::runApp(app_dir, display.mode = "normal")
}

