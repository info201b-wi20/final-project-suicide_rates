rm(list = ls())
library("dplyr")
library("ggplot2")
library("plotly")

suicide_gdp_chart <- function() {
  data <- read.csv("data/suicide-rates-overview-1985-to-2016.csv",
    stringsAsFactors = FALSE
  )

  # Correlation on suicide rate versus gdp (with country names)

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

  plot <- ggplot(sum_info_2, aes(
    y = suicides.100k.pop,
    x = gdp_per_capita...., color = year,
    label = country
  )) +
    labs(
      title = "A Plot on suicide rate versus gdp per capita",
      x = "GDP per Capita", y = "Suicide Number per 100k Population"
    ) +
    geom_point(show.legend = FALSE) +
    facet_wrap(~year, ncol = 3)

  chart <- ggplotly(plot)
  return(chart)
}
