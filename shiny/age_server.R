# Age VS Suicide Rate
data <- read.csv("../data/suicide-rates-overview-1985-to-2016.csv",
                 stringsAsFactors = FALSE
)


output$age_plot <- renderPlotly({
  suicide_age_chart <- function() {
    # Correlation on suicide rate versus age (with genders)
    year_2014_to_2016 <- data %>%
      filter(year >= 2014) %>%
      select(
        country, year, sex, age, suicides_no,
        suicides.100k.pop, gdp_per_capita....
      )

    sum_info <- year_2014_to_2016 %>%
      mutate(age = factor(age, levels = c(
        "5-14 years",
        "15-24 years", "25-34 years",
        "35-54 years", "55-74 years",
        "75+ years"
      ))) %>%
      # Filter by check boxes
      select(input$age_choice)

    sum_info_1 <- sum_info %>%
      group_by(age, sex) %>%
      summarise(suicides_no = sum(suicides_no))
    
    if (input$gender == "1") {
      sum_info_1 <- sum_info %>%
        group_by(age, sex) %>%
        summarise(suicides_no = sum(suicides_no)) %>%
        filter(sex == "female")
    } else if (input$gender == "2") {
      sum_info_1 <- sum_info %>%
        group_by(age, sex) %>%
        summarise(suicides_no = sum(suicides_no)) %>%
        filter(sex == "male")
    }
  }

  plot <- ggplot(sum_info_1, aes(age, suicides_no, fill = sex)) +
    geom_bar(stat = "identity", position = "dodge") +
    labs(
      title = "A Plot on suicide rate versus age",
      x = "Age", y = "Suicide Number"
    )

  chart <- ggplotly(plot)
  return(chart)
})
