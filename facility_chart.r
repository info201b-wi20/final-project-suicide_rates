library(dplyr)
library(ggplot2)
library(mapproj)

create_map <- function(){
  df_facility <- read.csv("data/Mental Health Facilities.csv", stringsAsFactors= FALSE)
  df_countries <- read.csv("data/suicide-rates-overview-1985-to-2016.csv", stringsAsFactors = FALSE)
  
  df_filtered_countries <- data.frame()
  
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
                                      na.rm = TRUE)
    )
  
  df_plotting <- df_countries_filtered %>%
    mutate(
      total_avalibility = df_facility_filtered$total_avalibility_per100k
    )
  
  world_shape <- map_data("world") %>%
    rename(country = region) %>%
    left_join(df_plotting, by="country")
  
  blank_theme <- theme_bw() +
    theme(
      axis.line = element_blank(),        # remove axis lines
      axis.text = element_blank(),        # remove axis labels
      axis.ticks = element_blank(),       # remove axis ticks
      axis.title = element_blank(),       # remove axis titles
      plot.background = element_blank(),  # remove gray background
      panel.grid.major = element_blank(), # remove major grid lines
      panel.grid.minor = element_blank(), # remove minor grid lines
      panel.border = element_blank()      # remove border around plot
    )
  
  facility_map <- ggplot(world_shape) +
    geom_polygon(
      mapping = aes(x = long, y = lat, group = group, fill = total_avalibility),
      color = "white",
      size = .1
    ) +
    coord_map(xlim=c(-180,180)) +
    scale_fill_continuous(low = "#cc3300", high = "#800000") +
    labs(fill = "total_avalibility") +
    blank_theme
  
  return(facility_map)
}

