library(plotly)

# Define content for the age VS suicide chart
page_age <- tabPanel(
  "Age VS Suicide Rate", # label for the tab in the navbar
  # This content uses a sidebar layout
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("age_choice", 
                         label = h3("Choose the Age Ranges"), 
                         choices = list("5-14 years" = 1, 
                                        "15-24 years" = 2, 
                                        "25-34 years" = 3,
                                        "35-54 years" = 4, 
                                        "55-74 years" = 5,
                                        "75+ years" = 6),
                         selected = c(1, 2, 3, 4, 5, 6)),
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
