# ETC5523: Assignment 4 - gradmajors R Package

This repository contains the work and materials for Assignment 4 of the ETC5523 unit (Communicating with Data).

## Overview

The 'gradmajors' package provides tools for visualizing and analyzing data related to U.S. college majors from the years 2010 to 2012. Explore employment rates, gender representation, and more to gain insights into college education and career outcomes in the United States.

## Installation

You can install this package directly from GitHub using the `devtools` package. If you haven't already installed `devtools`, you can do so by running the following command:

``` r
install.packages("devtools")
```

Once you have devtools installed, you can install the 'gradmajors' package from GitHub as follows:

``` r
devtools::install_github("ETC5523-2023/rpkg-agoh0008")
```

## Functions

- **'average_employment_rate':** Calculate the average employment rate for a specific major category.

- **'calc_female_grad_percent':** Calculate the percentage of female graduates in a major category.

- **'generate_gender_representation_plot':** Generate an interactive gender distribution plot for college majors within a category.

- **'run_app':** Launch a Shiny application for interactive visualizations and analysis relatd to U.S. college majors data (2010-2012).

  
## Usage Examples

Here are some examples of how to use the functions in the 'gradmajors' package:

- Calculate average employment rate for Engineering majors

``` r
average_employment_rate(recent_grads, "Engineering")
```

- Calculate the percentage of female graduates in Business majors

``` r
calc_female_grad_percent(recent_grads, "Business")
```

- Generate a gender distribution plot for Arts majors

``` r
generate_gender_representation_plot("Arts", "All", recent_grads)
```

- Launch the Shiny application

```r
run_app()
```


## License

This package is licensed under the MIT License. See the LICENSE file for details.


## URL 

The URL to the package documentation website can be found at https://651d0a6021358814d1ed92a9--rpkg-agoh0008-35d745.netlify.app/

