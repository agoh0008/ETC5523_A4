#' @name generate_gender_representation_plot
#' @title Generate a Gender Representation Plot for College Majors
#'
#' @description
#' This function generates an interactive plot displaying the gender distribution for college majors within a specific major category.
#'
#' @param major_category The major category you want to analyze.
#' @param selected_major A character vector specifying one or more specific majors within the major category. Use "All" to include all majors in the category.
#' @param data A data frame containing the dataset.
#'
#' @return An interactive plot showing the gender distribution for the selected major(s) within the specified major category.
#'
#' @examples
#' generate_gender_representation_plot("Arts", "All", recent_grads)
#' generate_gender_representation_plot("Engineering", c("Architecture", "Civil Engineering"), recent_grads)
#'
#' @importFrom plotly ggplotly
#' @import dplyr
#' @import ggplot2
#' @import tidyverse
#' @import tidyr
#' @import scales
#'
#' @export


generate_gender_representation_plot <- function(major_category, selected_major, data) {
  recent_grads <- data

  selected_major <- toupper(selected_major)

  filtered <- recent_grads %>%
    filter(
      !is.na(Major_category),
      !is.na(Total), !is.na(Men), !is.na(Women), !is.na(ShareWomen),
      Major_category == major_category
    )

  if ("ALL" %in% selected_major) {
    selected_major <- unique(filtered$Major)
  }

  if (!is.null(selected_major)) {
    if (any(!selected_major %in% filtered$Major)) {
      stop("Major does not exist in this category. Please try again.")
    }
    filtered <- filtered %>% filter(Major %in% selected_major)
  }

  filtered <- filtered %>%
    select(Major, Men, Women, ShareWomen, Total)

  filtered <- filtered %>%
    mutate(ShareMen = Men / Total)

  if (nrow(filtered) == 0) {
    stop("No data available for the specified major category and selected major(s).")
  }

  plot <- filtered %>%
    gather(key = "Gender", value = "Graduates", Men, Women) %>%
    ggplot(aes(x = Graduates, y = reorder(Major, -desc(Graduates)), fill = Gender,
               text = paste("Major:", Major, "<br>",
                            "Total Graduates:", scales::comma(Graduates, scale = 1), "<br>",
                            "Gender:", Gender, "<br>",
                            "Share:", scales::percent(ifelse(Gender == "Men", ShareMen, ShareWomen))))) +
    geom_bar(stat = "identity") +
    labs(x = "Number of Graduates", y = "Major", fill = "Gender",
         title = "Gender Distribution by College Major") +
    scale_fill_manual(values = c("blue", "#FC6C85")) +
    theme_minimal() +
    theme(axis.text.y = element_text(size = 8))

  return(ggplotly(plot, tooltip = c("text")))
}
