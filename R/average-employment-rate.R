#' @name average_employment_rate
#' @title Calculate Average Employment Rate for a Major Category
#' @description
#' This function calculates the average employment rate for a specific major category.
#' The employment rate is calculated as 100% minus the unemployment rate.
#'
#' @param data A data frame containing the dataset
#' @param major_category The major category for which you want to calculate the average employment rate.
#'
#' @return The average employment rate rounded to one decimal place.
#'
#' @examples
#' average_employment_rate(recent_grads, "Engineering")
#'
#' @import dplyr
#'
#' @export


average_employment_rate <- function(data, major_category) {
  filtered_data <- data %>%
    filter(tolower(Major_category) == tolower(major_category))

  if (missing(major_category) || is.null(major_category) || major_category == "") {
    stop("Major category is missing or empty.")
  }

  if (nrow(filtered_data) == 0) {
    stop("No data found for the specified major category.")
  }

  if (any(is.na(filtered_data$Unemployment_rate)) ||
      any(filtered_data$Unemployment_rate == 0)) {
    stop("Unemployment rate data is missing or contains zero values.")
  }

  avg_employment_rate <- round(mean(1 - filtered_data$Unemployment_rate)*100, 1)
  return(avg_employment_rate)
}

