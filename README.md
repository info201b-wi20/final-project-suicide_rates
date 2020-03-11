# Final Project [Report](https://info201b-wi20.github.io/final-project-suicide_rates/index)

**Suicide Rates**
- Our project will be investigating suicide rates globally in comparison to mental health facilities offered, and the socioeconomic status of each country. Suicide has become more widely talked about in social media in recent years, however it seems the awareness of mental health has been an emerging topic in developed countries but is not as emphasized in undeveloped countries. Suicide has resulted in the loss of many amazing people. As such, we want to investigate possible correlations between these different indicators, hopefully determining a reason or a trend for higher suicide rates in particular countries over others.

---

**Other projects related to this domain:**
- [Suicide Rate By Country 2020](http://worldpopulationreview.com/countries/suicide-rate-by-country/)
>- This project investigates suicide rates in each country, providing one map visualization. It focuses on particular countries of note (South Korea, Japan, Switzerland and China) and provides a more detailed background on suicide (particular historical and demographic trends) as well as the political and legal issues pertaining to suicide in those countries.
- [World Suicide Data Visualization with Tableau](https://medium.com/@lulu.ilmaknun.q/world-suicide-data-visualization-with-tableau-4464b68883f5)
>- This project focuses on certain trends in suicide rates based on demographics, such as age, race, gender and generation. As it is mainly displaying the capabilities of Tableau, the analysis is mainly graph-based.
- [Suicide - Our World in Data](https://ourworldindata.org/suicide)
>- This project investigates changes in suicide rates throughout the years, the global and demographic distribution of those rates, the breakdown of methods used to commit suicide, and possible risk factors for suicide. Multiple charts are provided to clearly display the distribution in each section being investigated.

---

**Questions we hope to answer:**
- Is there a correlation between a country’s socioeconomic status and its suicide rate?
>- Using data from "Suicide Rates Overview 1985 to 2016", we can directly graph each country's GDP per capita (an indicator for the standard of living) with it's suicide rate.
- Are there more mental health facilities for countries with higher suicide rates? Or is the number more closely correlated with the countries' socioeconomic status?
>- Using data from "Mental health service availability" and "Suicide Rates Overview 1985 to 2016", we will compare the many different mental health facilities and services available with the current suicide rate of each country and the "Suicide Rates Overview 1985 to 2016" GDP per capita.
- How does age and gender relate to the number of suicide rates? IS there a higher rate for a particular demographic?
>- Using "Suicide Rates Overview 1985 to 2016" and "OECD Data - Suicide Rates", we will graph the data for each demographic and determine if particular age groups or gender has a particular bearing on the quantity of suicides.

---

## Finding Data
- [Suicide Rates Overview 1985 to 2016](https://www.kaggle.com/russellyates88/suicide-rates-overview-1985-to-2016)
>- This data is collected by Kaggle’s user [Rusty] from United Nations Development Program, World Bank, [Szamil], and World Health Organization. It provides a Suicide Rate Overview from 1985 to 2016 consisting of multiple indicators including the GDP of each country.
>- There are 27,821 observations (rows) in this data.
>- There are 12 features (columns) in this data.
>- _Is there a correlation between a country’s socioeconomic status and its suicide rate?_
>- _How does age and gender relate to the number of suicide rates? IS there a higher rate for a particular demographic?_

- [Mental health service availability](http://apps.who.int/gho/data/node.main.MHFAC?lang=en)
>- The World Health Organization collected the data. It demonstrates the number of mental health facilities per 100000 population in observed countries from 2015 to 2017.
>- There are 164 rows in total, consisting of 164 countries under observation
>- There are seven columns in the data, featuring the number of mental hospitals, mental health units in general hospitals, mental health outpatient facilities, mental health day treatment facilities and community residential facilities per 1000000 population in the observed country.
>- _Is there a correlation between a country’s socioeconomic status and its suicide rate?_
>- _Are there more mental health facilities for countries with higher suicide rates? Or is the number more closely correlated with the countries' socioeconomic status?_

- [OECD Data - Suicide Rates](https://data.oecd.org/healthstat/suicide-rates.htm)
>- This data originated from the Organization for Economic Cooperation and Development, which came from the World Health Organization’s Mortality Database. The indicator is presented as a total, per gender, and is measured in terms of deaths per 100 000 inhabitants (total), per 100 000 men and per 100 000 women.
>- There are 5785 observations/rows (each row showcases a country’s suicide rate within a certain year - per 100,000 people)
>- There are 8 features/columns in this data
>- _How does age and gender relate to the number of suicide rates? IS there a higher rate for a particular demographic?_
