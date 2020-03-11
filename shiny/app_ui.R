library(plotly)

facility_page <- tabPanel(
  "Number of mental health facilties around the world",
  titlePanel("Total number of mental health facilities around the world and their effectiveness"),
  sidebarLayout(
    sidebarPanel(
      radioButtons(
        inputId = "facility_type",
        label = "Select the data you want to display",
        choices = c("Total number avaliable" = "total", 
                    "Ratio of number of suicides vs. number of facilities" = "ratio")
      ),
    ),
    mainPanel(
      plotlyOutput(outputId = "facility_plot")
    )
  )
)

page_gdp <- tabPanel(
  "GDP per Capita",
  titlePanel("A Plot on Average Suicide Rate Versus 
             Average GDP per Capita by Country"),
  sidebarLayout(
    sidebarPanel(
      h5(strong("Select the year(s)")),
      checkboxInput(
        "y2014",
        label = "Year 2014",
        value = TRUE
      ),
      checkboxInput(
        "y2015",
        label = "Year 2015",
        value = TRUE
      ),
      checkboxInput(
        "y2016",
        label = "Year 2016",
        value = TRUE
      ),
      sliderInput(
        inputId = "gdp_choice",
        label = "GDP per Capita Range",
        min = min(sum_info_2$gdp_per_capita....),
        max = max(sum_info_2$gdp_per_capita....),
        value = c(min, max)
      ),
      checkboxInput(
        "smooth",
        label = strong("Show Trendline"),
        value = TRUE
      )
    ),
    mainPanel(
      plotlyOutput("gdp_plot")
    )
  )
)

# Define content for the age VS suicide chart
page_age <- tabPanel(
  "Suicide Rate VS Age", # label for the tab in the navbar
  # This content uses a sidebar layout
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("age_choice",
                         label = h3("Choose the Age Ranges"),
                         choices = list(
                           "5-14 years",
                           "15-24 years",
                           "25-34 years",
                           "35-54 years",
                           "55-74 years",
                           "75+ years"
                         ),
                         selected = c(
                           "5-14 years",
                           "15-24 years",
                           "25-34 years",
                           "35-54 years",
                           "55-74 years",
                           "75+ years"
                         )
      ),
      radioButtons(
        inputId = "gender", label = h3("Choose the Gender:"),
        choices = list(
          "Female" = 1,
          "Male" = 2,
          "Both" = 3
        ),
        selected = 3
      ),
    ),
    mainPanel(
      h3("Suicide Rate VS Age & Gender"),
      plotlyOutput(outputId = "age_plot")
    )
  )
)

ui <- navbarPage(
  "Suicide Rates",
  page_age,
  page_gdp,
  facility_page
)