
#### **Data**

This data presents economic statistics (including median earnings, employment rates, 
gender distribution and more) for different college fields of study. The data is originally sourced 
from [American Community Survey 2010-2012 Public Use Microdata Series](https://www.census.gov/programs-surveys/acs/news/data-releases.html), with the main dataset being extracted from the [TidyTuesday GitHub Repository](https://github.com/rfordatascience/tidytuesday/tree/master/data/2018/2018-10-16).


#### **Purpose**

The purpose of the app is to:

1. provide an interactive platform for exploring economic data related to college majors and help users make informed educational/career decisions,
2. highlight majors with significant gender representation gaps, prompting users to reflect on these disparities and their implications, and
3. help users identify which college majors offer higher employment opportunities and median earnings. 

The data facilitates straightforward comparison of the number of male and female graduates across different college majors, highlighting gender representation disparities. The app also uses an interactive bubble chart to display major categories with their corresponding employment rates and median earnings, where users can gain a better perspective on how certain fields may be more in demand than others (note: size of each bubble represents total number of graduates). Finally, users can receive personalized major suggestions based on their input; recommendations also include information on median earnings, employment rates and job distributions for each relevant major.


#### **Creator**

Alexandra Goh (agoh0008@student.monash.edu)

<details>
<summary>Session information</summary>


```r
sessioninfo::session_info()
```

```
## ─ Session info ──────────────────────────────────────────────────────────────────
##  setting  value
##  version  R version 4.3.1 (2023-06-16 ucrt)
##  os       Windows 11 x64 (build 22621)
##  system   x86_64, mingw32
##  ui       RStudio
##  language (EN)
##  collate  English_Malaysia.utf8
##  ctype    English_Malaysia.utf8
##  tz       Australia/Sydney
##  date     2023-10-04
##  rstudio  2023.06.2+561 Mountain Hydrangea (desktop)
##  pandoc   NA
## 
## ─ Packages ──────────────────────────────────────────────────────────────────────
##  ! package     * version date (UTC) lib source
##    brio          1.1.3   2021-11-30 [1] CRAN (R 4.3.1)
##    bslib         0.5.1   2023-08-11 [1] CRAN (R 4.3.1)
##    cachem        1.0.8   2023-05-01 [1] CRAN (R 4.3.1)
##    callr         3.7.3   2022-11-02 [1] CRAN (R 4.3.1)
##    cli           3.6.1   2023-03-23 [1] CRAN (R 4.3.1)
##    colorspace    2.1-0   2023-01-23 [1] CRAN (R 4.3.1)
##    commonmark    1.9.0   2023-03-17 [1] CRAN (R 4.3.1)
##    crayon        1.5.2   2022-09-29 [1] CRAN (R 4.3.1)
##    crosstalk     1.2.0   2021-11-04 [1] CRAN (R 4.3.1)
##    curl          5.0.1   2023-06-07 [1] CRAN (R 4.3.1)
##    data.table    1.14.8  2023-02-17 [1] CRAN (R 4.3.1)
##    desc          1.4.2   2022-09-08 [1] CRAN (R 4.3.1)
##    devtools      2.4.5   2022-10-11 [1] CRAN (R 4.3.1)
##    digest        0.6.33  2023-07-07 [1] CRAN (R 4.3.1)
##    dplyr       * 1.1.2   2023-04-20 [1] CRAN (R 4.3.1)
##    ellipsis      0.3.2   2021-04-29 [1] CRAN (R 4.3.1)
##    evaluate      0.21    2023-05-05 [1] CRAN (R 4.3.1)
##    fansi         1.0.4   2023-01-22 [1] CRAN (R 4.3.1)
##    farver        2.1.1   2022-07-06 [1] CRAN (R 4.3.1)
##    fastmap       1.1.1   2023-02-24 [1] CRAN (R 4.3.1)
##    forcats     * 1.0.0   2023-01-29 [1] CRAN (R 4.3.1)
##    fs            1.6.3   2023-07-20 [1] CRAN (R 4.3.1)
##    generics      0.1.3   2022-07-05 [1] CRAN (R 4.3.1)
##    ggplot2     * 3.4.2   2023-04-03 [1] CRAN (R 4.3.1)
##    glue          1.6.2   2022-02-24 [1] CRAN (R 4.3.1)
##  P gradmajors  * 0.0.1   2023-10-04 [?] load_all()
##    gtable        0.3.3   2023-03-21 [1] CRAN (R 4.3.1)
##    hms           1.1.3   2023-03-21 [1] CRAN (R 4.3.1)
##    htmltools     0.5.5   2023-03-23 [1] CRAN (R 4.3.1)
##    htmlwidgets   1.6.2   2023-03-17 [1] CRAN (R 4.3.1)
##    httpuv        1.6.11  2023-05-11 [1] CRAN (R 4.3.1)
##    httr          1.4.7   2023-08-15 [1] CRAN (R 4.3.1)
##    janitor       2.2.0   2023-02-02 [1] CRAN (R 4.3.1)
##    jquerylib     0.1.4   2021-04-26 [1] CRAN (R 4.3.1)
##    jsonlite      1.8.7   2023-06-29 [1] CRAN (R 4.3.1)
##    knitr         1.44    2023-09-11 [1] CRAN (R 4.3.1)
##    labeling      0.4.3   2023-08-29 [1] CRAN (R 4.3.1)
##    later         1.3.1   2023-05-02 [1] CRAN (R 4.3.1)
##    lazyeval      0.2.2   2019-03-15 [1] CRAN (R 4.3.1)
##    lifecycle     1.0.3   2022-10-07 [1] CRAN (R 4.3.1)
##    lubridate   * 1.9.2   2023-02-10 [1] CRAN (R 4.3.1)
##    magrittr      2.0.3   2022-03-30 [1] CRAN (R 4.3.1)
##    markdown      1.7     2023-05-16 [1] CRAN (R 4.3.1)
##    memoise       2.0.1   2021-11-26 [1] CRAN (R 4.3.1)
##    mime          0.12    2021-09-28 [1] CRAN (R 4.3.0)
##    miniUI        0.1.1.1 2018-05-18 [1] CRAN (R 4.3.1)
##    munsell       0.5.0   2018-06-12 [1] CRAN (R 4.3.1)
##    pillar        1.9.0   2023-03-22 [1] CRAN (R 4.3.1)
##    pkgbuild      1.4.2   2023-06-26 [1] CRAN (R 4.3.1)
##    pkgconfig     2.0.3   2019-09-22 [1] CRAN (R 4.3.1)
##    pkgload       1.3.2.1 2023-07-08 [1] CRAN (R 4.3.1)
##    plotly      * 4.10.2  2023-06-03 [1] CRAN (R 4.3.1)
##    prettyunits   1.1.1   2020-01-24 [1] CRAN (R 4.3.1)
##    processx      3.8.2   2023-06-30 [1] CRAN (R 4.3.1)
##    profvis       0.3.8   2023-05-02 [1] CRAN (R 4.3.1)
##    promises      1.2.0.1 2021-02-11 [1] CRAN (R 4.3.1)
##    ps            1.7.5   2023-04-18 [1] CRAN (R 4.3.1)
##    purrr       * 1.0.2   2023-08-10 [1] CRAN (R 4.3.1)
##    R6            2.5.1   2021-08-19 [1] CRAN (R 4.3.1)
##    rcmdcheck     1.4.0   2021-09-27 [1] CRAN (R 4.3.1)
##    Rcpp          1.0.11  2023-07-06 [1] CRAN (R 4.3.1)
##    readr       * 2.1.4   2023-02-10 [1] CRAN (R 4.3.1)
##    remotes       2.4.2.1 2023-07-18 [1] CRAN (R 4.3.1)
##    rlang         1.1.1   2023-04-28 [1] CRAN (R 4.3.1)
##    roxygen2      7.2.3   2022-12-08 [1] CRAN (R 4.3.1)
##    rprojroot     2.0.3   2022-04-02 [1] CRAN (R 4.3.1)
##    rsconnect   * 1.1.0   2023-09-05 [1] CRAN (R 4.3.1)
##    rstudioapi    0.15.0  2023-07-07 [1] CRAN (R 4.3.1)
##    sass          0.4.7   2023-07-15 [1] CRAN (R 4.3.1)
##    scales        1.2.1   2022-08-20 [1] CRAN (R 4.3.1)
##    sessioninfo   1.2.2   2021-12-06 [1] CRAN (R 4.3.1)
##    shiny       * 1.7.4.1 2023-07-06 [1] CRAN (R 4.3.1)
##    snakecase     0.11.1  2023-08-27 [1] CRAN (R 4.3.1)
##    stringi       1.7.12  2023-01-11 [1] CRAN (R 4.3.0)
##    stringr     * 1.5.0   2022-12-02 [1] CRAN (R 4.3.1)
##    testthat    * 3.1.10  2023-07-06 [1] CRAN (R 4.3.1)
##    tibble      * 3.2.1   2023-03-20 [1] CRAN (R 4.3.1)
##    tidyr       * 1.3.0   2023-01-24 [1] CRAN (R 4.3.1)
##    tidyselect    1.2.0   2022-10-10 [1] CRAN (R 4.3.1)
##    tidyverse   * 2.0.0   2023-02-22 [1] CRAN (R 4.3.1)
##    timechange    0.2.0   2023-01-11 [1] CRAN (R 4.3.1)
##    tzdb          0.4.0   2023-05-12 [1] CRAN (R 4.3.1)
##    urlchecker    1.0.1   2021-11-30 [1] CRAN (R 4.3.1)
##    usethis       2.2.2   2023-07-06 [1] CRAN (R 4.3.1)
##    utf8          1.2.3   2023-01-31 [1] CRAN (R 4.3.1)
##    vctrs         0.6.3   2023-06-14 [1] CRAN (R 4.3.1)
##    viridisLite   0.4.2   2023-05-02 [1] CRAN (R 4.3.1)
##    withr         2.5.0   2022-03-03 [1] CRAN (R 4.3.1)
##    xfun          0.39    2023-04-20 [1] CRAN (R 4.3.1)
##    xml2          1.3.5   2023-07-06 [1] CRAN (R 4.3.1)
##    xopen         1.0.0   2018-09-17 [1] CRAN (R 4.3.1)
##    xtable        1.8-4   2019-04-21 [1] CRAN (R 4.3.1)
##    yaml          2.3.7   2023-01-23 [1] CRAN (R 4.3.0)
## 
##  [1] C:/Users/USER/AppData/Local/R/win-library/4.3
##  [2] C:/Program Files/R/R-4.3.1/library
## 
##  P ── Loaded and on-disk path mismatch.
## 
## ─────────────────────────────────────────────────────────────────────────────────
```
</details>
