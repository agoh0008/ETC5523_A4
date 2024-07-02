#' @name calc_female_grad_percent
#' @title Calculate Proportion of Female Graduates for a Major Category
#' @description
#' This function calculates the percentage of female graduates in a specific major category.
#'
#' @param data A data frame containing the dataset
#' @param major_category The major category for which you want to calculate the proportion of female graduates.
#'
#' @return The percentage of female graduates rounded to one decimal place.
#'
#' @examples
#' calc_female_grad_percent(recent_grads, "Engineering")
#' calc_female_grad_percent(recent_grads, "Business")
#'
#' @import dplyr
#'
#' @export


calc_female_grad_percent <- function(data, major_category) {
  filtered_data <- data %>%
    filter(tolower(Major_category) == tolower(major_category))

  if (nrow(filtered_data) == 0) {
    stop("No data found for the specified major category.")
  }

  total_women <- sum(filtered_data$Women)
  total_men <- sum(filtered_data$Men)

  if (total_women + total_men == 0) {
    stop("No data available for calculating the proportion of female graduates.")
  }

  women_percentage <- round((total_women / (total_women + total_men)) * 100, 1)
  return(women_percentage)
}

