## code to prepare `recent_grads` dataset goes here

library(usethis)
library(janitor)
library(tidyverse)
url <- 'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2018/2018-10-16/recent-grads.csv'


recent_grads <- read_csv(url)

usethis::use_data(recent_grads, overwrite = TRUE)




