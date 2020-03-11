library(dplyr)
library(ggplot2)
library(plotly)
library(scales)
library(mapproj)

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
  
  output$facility_plot <- renderPlotly({
    df_facility <- 
      read.csv("../data/Mental Health Facilities.csv", stringsAsFactors = FALSE)
    df_countries <- 
      read.csv("../data/suicide-rates-overview-1985-to-2016.csv", stringsAsFactors = FALSE)
    
    matches <- df_facility %>%
      select(Country, Year)
    
    df_countries_filtered <- df_countries %>%
      filter(year %in% matches$Year) %>%
      filter(country %in% matches$Country) %>%
      group_by(country) %>%
      filter(year == max(year)) %>%
      summarise(
        suicides_number = sum(suicides_no),
        gpd_per_capita = mean(gdp_per_capita....),
        suicides_100kpop = sum(suicides.100k.pop)
      )
    
    df_facility_filtered <- df_facility %>%
      filter(Country %in% df_countries_filtered$country) %>%
      group_by(Country) %>%
      summarise(
        total_avalibility_per100k = sum(Mental.hospitals..per.100.000.population.,
                                        Mental.health.units.in.general.hospitals..per.100.000.population.,
                                        Mental.health.outpatient.facilities..per.100.000.population.,
                                        Mental.health.day.treatment.facilities..per.100.000.population.,
                                        Community.residential.facilities..per.100.000.population.,
                                        na.rm = TRUE
        )
      )
    
    df_plotting <- df_countries_filtered %>%
      mutate(
        total_avalibility = df_facility_filtered$total_avalibility_per100k,
        ratio = suicides_100kpop/total_avalibility
      )
    
    df <- read.csv('https://raw.githubusercontent.com/plotly/datasets/master/2014_world_gdp_with_codes.csv', 
                   stringsAsFactors = FALSE)
    
    df <- df  %>%
      rename(country = COUNTRY) %>%
      left_join(df_plotting, by="country")
    
    df[is.na(df)] = 0
    
    l <- list(color = toRGB("grey"), width = 0.5)
    
    g <- list(
      showframe = FALSE,
      showcoastlines = FALSE,
      projection = list(type = 'Mercator')
    )
    
    fig <- plot_geo(df)
    
    if (input$facility_type == "total"){
      fig <- fig %>% add_trace(
        z = ~total_avalibility, color = ~total_avalibility, colors = 'Reds',
        text = ~country, locations = ~CODE, marker = list(line = l)
      )
      fig <- fig %>% colorbar(title = 'Total number')
      fig <- fig %>% layout(
        title = 'Global avalibility mental heath facilities(per 100k population)',
        geo = g
      )
    } else {
      fig <- fig %>% add_trace(
        z = ~ratio, color = ~ratio, colors = 'Reds',
        text = ~country, locations = ~CODE, marker = list(line = l)
      )
      fig <- fig %>% colorbar(title = 'Intensity')
      fig <- fig %>% layout(
        title = 'The intensity of need in mental heath facilities',
        geo = g
      )
    }
    return(fig)
  })
  
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
      plot <- plot + geom_smooth(se = FALSE, color = "coral", method = "loess")
    }
    
    chart <- ggplotly(plot)
    
    return(chart)
  })
  
  output$age_plot <- renderPlotly({
    
      sum_info <- year_2014_to_2016 %>%
        mutate(age = factor(age, levels = c(
          "5-14 years",
          "15-24 years", "25-34 years",
          "35-54 years", "55-74 years",
          "75+ years"
        ))) %>%
        # Filter by check boxes
        filter(age == input$age_choice)
      
#      sum_info_1 <- sum_info %>%
#        group_by(age, sex) %>%
#        summarise(suicides_no = sum(suicides_no))
      
      if (input$gender == "1") {
        sum_info_1 <- sum_info %>%
          group_by(age, sex) %>%
          filter(sex == "female") %>%
          summarise(suicides_no = sum(suicides_no))
          
      } else if (input$gender == "2") {
        sum_info_1 <- sum_info %>%
          group_by(age, sex) %>%
          filter(sex == "male") %>%
          summarise(suicides_no = sum(suicides_no))
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
}
