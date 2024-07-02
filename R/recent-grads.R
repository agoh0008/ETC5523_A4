#' @name recent_grads
#' @title Load and Prepare the recent_grads Dataset
#'
#' @description
#' This function loads and prepares the `recent_grads` dataset for analysis.
#' It downloads the dataset from the specified URL, reads it into a data frame,
#' and performs any necessary data cleaning or preprocessing.
#'
#' @param url The URL of the dataset to download.
#'
#' @return A cleaned and prepared data frame containing the `recent_grads` dataset.
#'
#' @examples
#' \dontrun{
#' # Load and prepare the dataset
#' recent_grads <- load_and_prepare_recent_grads(
#'   'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2018/2018-10-16/recent-grads.csv'
#' )
#' }
#'
#' @import usethis
#' @import janitor
#' @import tidyverse
#'
#' @export

load_and_prepare_recent_grads <- function(url) {

  url <- 'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2018/2018-10-16/recent-grads.csv'
  recent_grads <- read_csv(url)

  return(recent_grads)
}
