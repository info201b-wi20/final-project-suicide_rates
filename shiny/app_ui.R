library(plotly)

overview <- tabPanel(
  "Overview",
  h1("Suicide Rates"),
  h5("Project by Adam Ahmed, Yudong Li, Michelle Oceana, Ploypilin Pruekcharoen"),
  
  p("Suicide is the act of intentionally causing one's own death, and, in many ways,
    a deep tragedy to others. It is a desperate attempt to escape suffering that has
    become unbearable. Blinded by feelings of self-loathing, hopelessness, and isolation, 
    someone who is feeling suicidal can’t see any way of finding relief except through death.
    It is an important subject we need to discuss, however, stigma surrounding suicide 
    leads to underreporting, and data collection methods critical to suicide prevention
    need to be improved."),
  
  p("Our project will be investigating suicide rates globally in comparison to 
    mental health facilities offered, age groups, and the socioeconomic status of each country.
    For this project, we used combined data from both Suicide Rates Overview 1985 to 2016 and 
    Mental health service availability to create data visualizations that may aid us in 
    finding these trends."),
  
  p(""),
  h3("Questions we hope to answer:"),
  p(strong("Is there a correlation between a country’s socioeconomic status and its suicide rate?")),
  
  p("Using data from Kaggle, we can directly graph each country's
  GDP per capita (an indicator for the standard of living) with it's suicide rate."),
  
  p(strong("Are there more mental health facilities for countries with higher suicide rates?
  Or is the number more closely correlated with the countries' socioeconomic status?")),
  
  p("Using data from the World Health Organization and Kaggle we
  will compare the many different mental health facilities and services available with the current
  suicide rate of each country and the GDP per capita from 1985 to 2016."),
  
  p(strong("How does age and gender relate to the number of suicide rates? Is there a higher rate
    for a particular demographic?")),
  
  p("Using Kaggle and World Health Organization data, we will
    graph the data for each demographic and determine if particular age groups or gender has
    a particular bearing on the quantity of suicides."),
  
  p(""),
  h3("Data Link"),
  a("Kaggle", href = "https://www.kaggle.com/russellyates88/suicide-rates-overview-1985-to-2016"),
  p(""),
  a("World Health Organization", href = "http://apps.who.int/gho/data/node.main.MHFAC?lang=en"),
  p(""),
  img(src = "https://www.advocate.com/sites/advocate.com/files/2019/06/11/troubled-youthx750.jpg")
)

facility_page <- tabPanel(
  "Number of mental health facilties around the world",
  h3("Total number of mental health facilities around the world and their effectiveness"),
  sidebarLayout(
    sidebarPanel(
      radioButtons(
        inputId = "facility_type",
        label = h4("Select the data you want to display"),
        choices = c("Total number avaliable" = "total", 
                    "Ratio of number of suicides vs. number of facilities" = "ratio")
      ),
    ),
    mainPanel(
      plotlyOutput(outputId = "facility_plot"),
      p(id = "heath_care_description",
        "This interactive map is aimed to provide an overview of mental heath facilities 
        around the world. It has tow main parameters: the total number of units available 
        per 100,000 population and the ratio of number of suicides over the number of 
        facilities in selected countries. Although the total number of facilities available 
        is a good way to demonstrate a country’s strength in providing mental health support, 
        the ratio reveals a more important aspect that whether a country’s mental health 
        facilities are capable to compensate all the suicide cases, that the lower ratio 
        means the higher effectiveness of the facilities to prevent suicides. 
        Unfortunately, even the World Health Organization does not provide sufficient data on 
        the mental heath facilities around the global, so only 69 countries are demonstrated 
        in this map. The countries without information have value 0 for both parameters on the map."
      )
    )
  )
)

page_gdp <- tabPanel(
  "GDP per Capita",
  h3("A Plot on Average Suicide Rate Versus 
             Average GDP per Capita by Country"),
  sidebarLayout(
    sidebarPanel(
      h4("Select the year(s)"),
      checkboxInput(
        "y2014",
        label = "Year 2014",
        value = TRUE
      ),
      checkboxInput(
        "y2015",
        label = "Year 2015",
        value = TRUE
      ),
      checkboxInput(
        "y2016",
        label = "Year 2016",
        value = TRUE
      ),
      sliderInput(
        inputId = "gdp_choice",
        label = h4("GDP per Capita Range"),
        min = min(sum_info_2$gdp_per_capita....),
        max = max(sum_info_2$gdp_per_capita....),
        value = c(min, max)
      ),
      checkboxInput(
        "smooth",
        label = strong("Show Trendline"),
        value = TRUE
      )
    ),
    mainPanel(
      plotlyOutput("gdp_plot")
    )
  )
)

# Define content for the age VS suicide chart
page_age <- tabPanel(
  "Suicide Rate VS Age", # label for the tab in the navbar
  # This content uses a sidebar layout
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("age_choice",
                         label = h4("Choose the Age Ranges"),
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
        inputId = "gender", label = h4("Choose the Gender:"),
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
      plotlyOutput(outputId = "age_plot")
    )
  )
)

summary_page <- tabPanel(
  "Summary",
  h3("Key Takeaways"),
  p("1. The countries with the highest suicide rates (300-400 per 100k population) were 
    within 0-0.5 million GDP per Capita while countries with GDP per capita between 1 million
    and 1.5 million had suicide rates under 200(per 100k population). This shows that those who was born
    in a country of lower socioeocnomic status had a higher chance of committing suicide at some point
    during their life."),
  
  p("2. When tracking the effectiveness of mental health facilities across the globe,
    there doesn’t appear to be a trend in particular regions, but the regions with 
    the least effect tend to be significantly smaller than many of the other lighter regions."),
  
  p("3. In our age and gender visualization, Suicide rates tend to be the highest at ages 35-54,
    also known as when people are reaching their middle ages. In addition, when comparing genders,
    there tends to be more males who are likely to commit suicide than females."),
  
  p(id = "call" ,"If you’re thinking about suicide, are worried about a friend or loved on,
     or would like emotional support, call the number 1-800-273-8255 and speak
     with a counselor today.")
)

ui <- fluidPage(
  includeCSS("style.css"),
  navbarPage(
  "Suicide Rates",
  overview,
  page_age,
  page_gdp,
  facility_page,
  summary_page
  )
)