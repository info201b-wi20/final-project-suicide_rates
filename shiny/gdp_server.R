library(dplyr)
library(ggplot2)
library(plotly)
library(scales)

data <- read.csv("../data/suicide-rates-overview-1985-to-2016.csv",
                 stringsAsFactors = FALSE
)

year_2014_to_2016 <- data %>%
  filter(year >= 2014) %>%
  select(
    country, year, sex, age, suicides_no,
    suicides.100k.pop, gdp_per_capita....
  )

sum_info_2 <- year_2014_to_2016 %>%
  group_by(country, year) %>%
  summarise(
    suicides.100k.pop = round(mean(suicides.100k.pop), digits = 2),
    gdp_per_capita.... = round(mean(gdp_per_capita....), digits = 2)
  )

server <- function(input, output) {
  
  output$gdp_plot <- renderPlotly({
    
    if (!input$y2014) {
      sum_info_2 <- sum_info_2 %>%
        filter(year != 2014)
    }
    if (!input$y2015) {
      sum_info_2 <- sum_info_2 %>%
        filter(year != 2015)
    }
    if (!input$y2016) {
      sum_info_2 <- sum_info_2 %>%
        filter(year != 2016)
    }
    
    plot <- ggplot(sum_info_2, aes(
      y = suicides.100k.pop,
      x = gdp_per_capita....,
      color = year,
      label = country
      )
    ) +
      labs(
        title = "A Plot on suicide rate versus gdp per capita",
        x = "Average GDP per Capita",
        y = "Average Suicide Number per 100k Population"
      ) +
      theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
      scale_x_continuous(labels = comma, limits = input$gdp_choice) +
      geom_point(show.legend = FALSE) +
      facet_wrap(~year, ncol = 3)
    
    if (input$smooth) {
      plot <- plot + geom_smooth(se = FALSE, color = "coral")
    }
    
    chart <- ggplotly(plot)
    
    return(chart)
  })
  
  # Age VS Suicide Rate
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
        )))
      
      sum_info_1 <- sum_info %>%
        group_by(age, sex) %>%
        summarise(suicides_no = sum(suicides_no))
      
      plot <- ggplot(sum_info_1, aes(age, suicides_no, fill = sex)) +
        geom_bar(stat = "identity", position = "dodge") +
        labs(
          title = "A Plot on suicide rate versus age",
          x = "Age", y = "Suicide Number"
        )
      
      chart <- ggplotly(plot)
      return(chart)
    }
  })
}
