library(dplyr)

get_summary_information = function() {
  df_facility <- read.csv("data/Mental Health Facilities.csv")
  df_countries <- read.csv("data/suicide-rates-overview-1985-to-2016.csv")
  
  matches <- df_facility %>%
    select(Country, Year)
  
  df_countries_filtered <- df_countries %>%
    filter(year %in% matches$Year) %>%
    filter(country %in% matches$Country) %>%
    group_by(country) %>%
    filter(year == max(year)) %>%
    summarise(
      "Gpd per capita" = mean(gdp_per_capita....),
      "Number of suicides (per 100k population)" = sum(suicides.100k.pop)
    )
  
  df_facility_filtered <- df_facility %>%
    filter(Country %in% df_countries_filtered$country) %>%
    group_by(Country) %>%
    summarise(
      "total avalibility per 100k population" = sum(Mental.hospitals..per.100.000.population., 
                                                    Mental.health.units.in.general.hospitals..per.100.000.population.,
                                                    Mental.health.outpatient.facilities..per.100.000.population.,
                                                    Mental.health.day.treatment.facilities..per.100.000.population., 
                                                    Community.residential.facilities..per.100.000.population., 
                                                    na.rm = TRUE)
    )
  
  df_summary <- df_countries_filtered %>%
    mutate(
      "Mental Health Facility Avaliable(per 100k population)" = df_facility_filtered$"total avalibility per 100k population"
    )
  
  return(df_summary)
}

