library(plotly)

# Define content for the age VS suicide chart
page_age <- tabPanel(
  "Age VS Suicide Rate", # label for the tab in the navbar
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
        inputId = "gender", label = h3("Choose the Sex:"),
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
      p(paste(
        "Write the report here."
      )),

      plotlyOutput(outputId = "age_plot")
    )
  )
)
