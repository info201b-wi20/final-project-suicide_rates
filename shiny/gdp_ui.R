library(plotly)

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
  "Age VS Suicide Rate", # label for the tab in the navbar
  # This content uses a sidebar layout
  sidebarLayout(
    sidebarPanel(
      selectInput("age",
                  label = h3("Select the Age Range"),
                  choices = midwest$county,
                  selected = "COOK"
      ),
      
      radioButtons(
        inputId = "no_perc", label = h3("Numbers or Percentages?"),
        choices = list(
          "Number" = 1,
          "Percentage" = 2
        ),
        selected = 1
      ),
    ),
    mainPanel(
      h3("Populations of Demographic Groups:"),
      p(paste(
        "This is a pie chart of the distribution of",
        "demographics within a selected county (selected",
        "in the drop-down menu on the left).",
        "You can choose for the values shown to be in",
        "actual population numbers or in percentages.",
        "Not all counties are shown as these counties don't",
        "have populations of some of the races."
      )),
      strong("Try Gallatin & Vermilion!"),
      
      plotlyOutput(outputId = "pie")
    )
  )
)

ui <- navbarPage(
  "Suicide Rates",
  page_gdp,
  page_age
)