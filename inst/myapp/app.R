library(shiny)
library(tidyverse)
library(plotly)
library(rsconnect)


ui <- fluidPage(
  titlePanel("Economic Guide to Picking a College Major"),


  div(class = "section intro-section",
      p("Welcome to our interactive app, where you can dive into the world of college majors and see how they shape your career journey."),
      p("From exploring ", strong("gender balance"), " across fields to understanding ", strong("earnings"), " and ", strong("employment rates"), ", our app helps you make better-informed choices."),
      p("Plus, get ", strong("personalized major recommendations"), " based on what you love and your earning goals."),
      p(class = "gap-paragraph", "Let's navigate this exciting data adventure together!")
  ),


  div(class = "section",
      h3(class = "plot-heading", "Comparing Gender Representation Across Majors"),
      p(class = "custom-paragraph",
        "Select a major category and major(s) of interest to explore how gender representation varies across different college majors. Adjust the slider to focus on specific ranges of share of women. Hover over each bar in the plot to get more detailed information."),
      p(class = "custom-paragraph",
        "For instance, did you know that all engineering majors have less than 50% of female graduates? Use the slider to find out!"),
      fluidRow(
        sidebarLayout(
          sidebarPanel(
            selectInput("major_category", "Filter by Major Category:",
                        choices = unique(recent_grads$Major_category)),
            uiOutput("major_select"),
            sliderInput("sharewomen_range", "Share of Women (%):",
                        min = 0, max = 100, value = c(0, 100), step = 1)
          ),
          mainPanel(
            plotlyOutput("genderPlot")
          )
        )
      )
  ),

  hr(class = "section-divider"),

  div(class = "section",
      h3(class = "plot-heading", "Median Earnings & Employment Rates Across Majors"),
      p(class = "custom-paragraph",
        "Select a major category from the dropdown to see how different majors compare in terms of median earnings and employment rates. As you dive into the data, you'll uncover valuable insights about which majors lead to higher earnings and better employment prospects."),
      p(class = "custom-paragraph",
        "Take a look at 'Computers & Mathematics': Computer Science stands out with the highest median earnings and an impressive 94% employment rate! A standout choice, isn't it?"),
      fluidRow(
        sidebarLayout(
          sidebarPanel(
            selectInput("major_category_2", "Filter by Major Category:",
                        choices = unique(recent_grads$Major_category)
            )),
          mainPanel(
            plotlyOutput("employmentMedianPlot")
          )
        )
      )
  ),

  hr(class = "section-divider"),

  div(class = "section",
      h3(class = "plot-heading", "Personalized College Major Recommendations"),
      p(class = "custom-paragraph",
        "Now it's your turn! Let's tailor your college major recommendations based on your interests, desired earnings, and preferred employment type. Use the options below to indicate your preferences, and we'll provide you with the top-three suggestions."),
      fluidRow(
        column(4,
               radioButtons("interests", "Select Interests:",
                            choices = unique(recent_grads$Major_category))
        ),
        column(4,
               numericInput("desired_earnings", "Desired Earnings ($):", value = 50000)
        ),
        column(4,
               radioButtons("preferred_employment", "Preferred Employment:",
                            choices = c("Full-time", "Part-time"), selected = "Full-time")
        )
      ),
      fluidRow(
        column(12,
               actionButton("submit_button", "Submit"),
               div(class = "image-container",
                   img(src = "majors.png", width = "auto",
                       height = "400px", align = "right"))
        )
      ),
      fluidRow(
        column(12,
               div(style = "margin-top: -300px; margin-bottom: 20px;",
                   tableOutput("recommendations"))
        )
      )
  ),

  tags$style(HTML("
    .section {
      padding: 20px;
      border: 1px solid #ccc;
      border-radius: 5px;
      margin-bottom: 20px;
    }

    .intro-section {
    margin-bottom: 20px;
    margin-top: -20px;
    border: none;
    }

    .section-divider {
      margin-top: 40px;
      margin-bottom: 40px;
      border: none;
      border-top: 1px dashed #aaa;
    }

    .image-container {
      position: relative;
      top: -400px;
      left: -200px;
    }

    .clear-fix::after {
      content: '';
      display: table;
      clear: both;
    }

    .plot-heading {
      margin-bottom: 20px;
    }

  ")),

  fluidRow(
    column(10,
           div(class = "about",
               uiOutput('about'))
    )
  ),
  includeCSS("styles.css")
)



server <- function(input, output, session) {
  recent_grads <- read.csv("recent-grads.csv")

  output$major_select <- renderUI({
    req(input$major_category)
    majors <- unique(recent_grads$Major[recent_grads$Major_category == input$major_category])

    checkbox_group <- checkboxGroupInput("major", "Select Major:", choices = majors,
                                         selected = input$major)

    scrollable_checkbox_group <- div(style = "max-height: 300px; overflow-y: auto;", checkbox_group)

    scrollable_checkbox_group
  })


  filtered_data <- reactive({
    selected_range <- input$sharewomen_range / 100
    majors_selected <- input$major

    filtered <- recent_grads %>%
      filter(
        !is.na(Major_category),
        !is.na(Total), !is.na(Men), !is.na(Women), !is.na(ShareWomen),
        Major_category == input$major_category,
        ShareWomen >= selected_range[1] & ShareWomen <= selected_range[2]
      )

    if (is.null(majors_selected) || "All" %in% majors_selected) {
      filtered <- filtered
    } else {
      filtered <- filtered %>% filter(Major %in% majors_selected)
    }

    filtered
  })


  filtered_data_2 <- reactive({
    recent_grads %>%
      filter(
        !is.na(Major_category),
        Major_category == input$major_category_2
      )
  })


  output$genderPlot <- renderPlotly({
    filtered <- filtered_data()
    gender_data <- filtered %>% select(Major, Men, Women, ShareWomen, Total)

    selected_majors <- unique(recent_grads$Major[recent_grads$Major_category == input$major_category])

    if (!is.null(input$major) && "" %in% input$major) {
      selected_majors <- unique(recent_grads$Major[recent_grads$Major_category == input$major_category])
    } else if (!is.null(input$major)) {
      selected_majors <- input$major
    }

    gender_data <- gender_data %>%
      filter(Major %in% selected_majors)

    gender_data <- gender_data %>%
      mutate(ShareMen = Men / Total)

    plot <- gender_data %>%
      gather(key = "Gender", value = "Graduates", Men, Women) %>%
      ggplot(aes(x = reorder(Major, -Graduates), y = Graduates, fill = Gender,
                 text = paste("Major:", Major, "<br>",
                              "Total Graduates:", scales::comma(Graduates, scale = 1), "<br>",
                              "Gender:", Gender, "<br>",
                              "Share:", scales::percent(ifelse(Gender == "Men", ShareMen, ShareWomen))))) +
      geom_bar(stat = "identity", position = position_dodge()) +
      labs(x = "Major", y = "Number of Graduates", fill = "Gender",
           title = "Gender Distribution by College Major") +
      scale_fill_manual(values = c("blue", "#FC6C85")) +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = ifelse(length(selected_majors) <= 2, 0, 45),
                                       hjust = ifelse(length(selected_majors) <= 2, 0.5, 1), size = 8))

    ggplotly(plot, tooltip = c("text"))
  })



  output$employmentMedianPlot <- renderPlotly({
    filtered <- filtered_data_2()

    filtered <- filtered %>%
      mutate(Employment_Rate = Employed / (Unemployed + Employed) * 100)

    plot <- filtered %>%
      ggplot(aes(x = Median, y = Employment_Rate, size = Total, color = Major,
                 text = paste("Major:", Major, "<br>",
                              "Median Earnings ($):", scales::comma(Median, scale = 1), "<br>",
                              "Employment Rate:", scales::comma(Employment_Rate, scale = 1), "%<br>",
                              "Total Graduates:", scales::comma(Total, scale = 1)))) +
      geom_point(alpha = 0.7) +
      scale_size_continuous(name = "Total Graduates") +
      labs(x = "Median Earnings (USD)", y = "Employment Rate (%)",
           title = "Median Earnings vs Employment Rate by Major",
           color = "Major") +
      theme_minimal()

    ggplotly(plot, tooltip = "text")
  })


  observeEvent(input$submit_button, {
    desired_earnings <- input$desired_earnings
    preferred_employment <- input$preferred_employment
    preferred_category <- input$interests

    recent_grads <- recent_grads %>%
      mutate(Full_time_Prop = (Full_time / Total) * 100,
             Part_time_Prop = (Part_time / Total) * 100,
             Employment_Rate = Employed / (Employed + Unemployed) * 100,
             Unemployment_Rate = Unemployment_rate * 100)

    if (preferred_employment == "Full-time") {
      recommended_majors <- recent_grads %>%
        filter(
          !is.na(Major_category),
          Major_category == preferred_category,
          Median >= desired_earnings,
          Full_time_Prop > 0,
          Unemployment_Rate > 0
        ) %>%
        arrange(desc(Full_time_Prop)) %>%
        select(Major, Median, Employment_Rate, Unemployment_Rate, Full_time_Prop, Part_time_Prop)
    } else {
      recommended_majors <- recent_grads %>%
        filter(
          !is.na(Major_category),
          Major_category == preferred_category,
          Median >= desired_earnings,
          Part_time_Prop > 0,
          Unemployment_Rate > 0
        ) %>%
        arrange(desc(Part_time_Prop)) %>%
        select(Major, Median, Employment_Rate, Unemployment_Rate, Full_time_Prop, Part_time_Prop)
    }

    recommended_majors <- head(recommended_majors, 3)


    output$recommendations <- renderTable({
      colnames(recommended_majors) <- c("Major", "Median Earnings (USD $)", "Employment Rate (%)", "Unemployment Rate (%)",
                                        "Graduates Working Full-time (%)", "Graduates Working Part-time (%)")
      recommended_majors$`Median Earnings (USD $)` <- scales::comma(recommended_majors$`Median Earnings (USD $)`)
      recommended_majors$`Employment Rate (%)` <- scales::percent(recommended_majors$`Employment Rate (%)`, scale = 1)
      recommended_majors$`Unemployment Rate (%)` <- scales::percent(recommended_majors$`Unemployment Rate (%)`, scale = 1)
      recommended_majors
    })
  })


  output$about <- renderUI({
    knitr::knit("about.Rmd", quiet = TRUE) %>%
      markdown::markdownToHTML(fragment.only = TRUE) %>%
      HTML()
  })
}


shinyApp(ui = ui, server = server)
