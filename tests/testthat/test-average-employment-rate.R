library(testthat)

test_that("average_employment_rate function calculates correctly", {
  sample_data <- data.frame(
    Major_category = c("Engineering", "Arts", "Business"),
    Unemployment_rate = c(0.05, 0.1, 0.08)
  )

  # Test case 1: Calculate average employment rate for Engineering majors
  result1 <- average_employment_rate(sample_data, "Engineering")
  expect_equal(result1, 95)  # Expected result for Engineering: 100 - (0.05 * 100) = 95

  # Test case 2: Calculate average employment rate for Business majors
  result2 <- average_employment_rate(sample_data, "Business")
  expect_equal(result2, 92)  # Expected result for Business: 100 - (0.08 * 100) = 92

  # Test case 3: Calculate average employment rate for a non-existent category
  expect_error(average_employment_rate(sample_data, "Health"), "No data found for the specified major category.")

  # Test case 4: Calculate average employment rate with missing/unavailable data
  sample_data_missing <- data.frame(
    Major_category = c("Engineering", "Arts", "Business"),
    Unemployment_rate = c(0.05, NA, 0.08)
  )
  expect_error(average_employment_rate(sample_data_missing, "Arts"), "Unemployment rate data is missing or contains zero values.")

  # Test case 5: Test if the function throws an error for missing, NULL, or empty major_category
  expect_error(average_employment_rate(sample_data, ""), "Major category is missing or empty.")

})
