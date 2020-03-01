rm(list = ls())
library("dplyr")
library("ggplot2")
library("plotly")

data <- read.csv("data/suicide-rates-overview-1985-to-2016.csv", stringsAsFactors = FALSE)

# Correlation on suicide rate versus age (side-by-side bar -> genders)

year_2014_to_2016 <- data %>%
  filter(year >= 2014) %>%
  select(country, year, sex, age, suicides_no, suicides.100k.pop, gdp_per_capita....)

sum_info_1 <- year_2014_to_2016 %>%
  group_by(age, sex) %>%
  summarise(suicides_no = sum(suicides_no))

plot <- ggplot(sum_info_1, aes(age, suicides_no, fill = sex)) +
  geom_bar(stat = "identity", position = "dodge") + 
  labs(title="A Plot on suicide rate versus age",
             x ="Age", y = "Suicide Number")

chart1 <- ggplotly(plot)

chart1







