# Summary Information Script
# The first file you should save in your scripts/ directory should contain a
# function that takes in a dataset as a parameter, and returns a list of
# information about it. For example:

library("dplyr")

get_summary_info <- function() {
  combined_table <- read.csv("data/combined_table.csv", stringsAsFactors = FALSE)
  
  
  return(list(
    countries_no = combined_table %>%
      nrow(),

    max_suicide_rate = combined_table %>%
      summarize(max_suicide = max(suicides_100kpop), na.rm = TRUE) %>%
      pull(max_suicide),

    average_gdp = combined_table %>%
      summarize(average = mean(gpd_per_capita), na.rm = TRUE) %>%
      pull(average),

    average_suicide_rate = combined_table %>%
      summarize(mean_rate = mean(suicides_100kpop)) %>%
      pull(mean_rate),

    average_mental_hospitals = combined_table %>%
      summarize(mean_hospitals = mean(total_avalibility)) %>%
      pull(mean_hospitals),
    
    col_names = dput(names(combined_table))
  ))
}