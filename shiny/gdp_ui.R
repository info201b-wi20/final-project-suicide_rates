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


ui <- navbarPage(
  "Suicide Rates",
  page_gdp
)