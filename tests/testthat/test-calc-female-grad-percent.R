library(testthat)

# Sample data frame for testing
sample_data <- data.frame(
  Major_category = c("Engineering", "Arts", "Business"),
  Women = c(100, 150, 200),
  Men = c(300, 250, 400)
)

test_that("calc_female_grad_percent function calculates correctly", {

  # Test case 1: Calculate proportion of female graduates for Engineering majors
  result1 <- calc_female_grad_percent(sample_data, "Engineering")
  expect_equal(result1, 25.0)  # Expected result for Engineering: (100 / (100 + 300)) * 100 = 25.0

  # Test case 2: Calculate proportion of female graduates for Business majors
  result2 <- calc_female_grad_percent(sample_data, "Business")
  expect_equal(result2, 33.3)  # Expected result for Business: (200 / (200 + 400)) * 100 = 33.3

  # Test case 3: Calculate proportion of female graduates for a non-existent category
  expect_error(calc_female_grad_percent(sample_data, "Health"), "No data found for the specified major category.")

  # Test case 4: Calculate proportion of female graduates with zero total graduates
  zero_data <- data.frame(
    Major_category = c("Engineering"),
    Women = c(0),
    Men = c(0)
  )
  expect_error(calc_female_grad_percent(zero_data, "Engineering"), "No data available for calculating the proportion of female graduates.")

})

