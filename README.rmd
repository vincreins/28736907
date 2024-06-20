---
title: "README"
output: github_document
---


```{r}

library(tidyr)
library(dplyr)
library(ggplot2)
library(tidyverse)

rm(list = ls()) # Clean your environment:
gc() # garbage collection - It can be useful to call gc after a large object has been removed, as this may prompt R to return memory to the operating system.
library(tidyverse)
list.files('/code/', full.names = T, recursive = T) %>% .[grepl('.R', .)] %>% as.list() %>% walk(~source(.))
```



```{r}

Texevier::create_template(directory = glue::glue("/Users/vr/Documents/Uni/VWL/Stellenbosch/DataScience/Exam"), template_name = "Question1")
Texevier::create_template(directory = glue::glue("/Users/vr/Documents/Uni/VWL/Stellenbosch/DataScience/Exam"), template_name = "Question2")
Texevier::create_template(directory = glue::glue("/Users/vr/Documents/Uni/VWL/Stellenbosch/DataScience/Exam"), template_name = "Question3")
Texevier::create_template(directory = glue::glue("/Users/vr/Documents/Uni/VWL/Stellenbosch/DataScience/Exam"), template_name = "Question4")
Texevier::create_template(directory = glue::glue("/Users/vr/Documents/Uni/VWL/Stellenbosch/DataScience/Exam"), template_name = "Question5")
```

Question 1:

Babynames

Load data sets

```{r}
baby_names <- readRDS("Question1/data/US_Baby_names/Baby_Names_By_US_State.rds")
charts <- read.csv("Question1/data/US_Baby_names/charts.csv")
HBO_Titles <- readRDS("Question1/data/US_Baby_names/HBO_titles.rds", TRUE)
HBO_Credits <- readRDS("Question1/data/US_Baby_names/HBO_credits.rds", TRUE)
Growth_rate <- read.csv("Question1/data/US_Baby_names/apportionment.csv")
```


The get_top_baby_names function extracts the top N baby names per gender-year combination from a dataset, aggregating name counts and assigning ranks based on frequency.

```{r}

baby_25 <- get_top_baby_names(baby_names, 25)


```

The perform_gender_correlation function calculates the Spearman correlation between counts of baby names for males and females.

```{r}
perform_gender_correlation(baby_25)
```


The name_persistence function computes the Spearman rank correlation between counts of baby names across specified years into the future, visualizing the correlation trends over time.

```{r}

name_persistence(baby_25, 3, 1990)

```


The function extract_first_name adds a new column first_name to a dataframe data, extracting the first names from a specified column Name_column containing full names

The movie_appearance_change function integrates data from HBO_Credits and HBO_Titles, identifying top HBO titles by popularity and joining them to analyze the impact of appearing in these movies on changes in movie appearances over subsequent years. It further models and visualizes these changes using linear regression and plots to illustrate trends in relative changes over time for individuals associated with HBO productions.

```{r}
HBO_Credits <- extract_first_name(HBO_Credits, "name")
movie_appearance_change(baby_25, HBO_Credits, HBO_Titles)
```


Question 2:

Load data sets

```{r}
coldplay <- read.csv("Question2/data/Coldplay_vs_Metallica/metallica.csv", encoding = "latin1")
metallica <- read.csv("Question2/data/Coldplay_vs_Metallica/Coldplay.csv")
charts <- readRDS("Question2/data/Coldplay_vs_Metallica/charts.rds")
spotify_info <- readRDS("Question2/data/Coldplay_vs_Metallica/Broader_Spotify_Info.rds")
```

The unique_songs function processes a dataset of songs (data), filtering out entries with hyphens or parentheses in their names, converting all song names to lowercase, and returning a dataset containing only unique song names while preserving all original columns.

The studio_recording function filters out entries containing the term "live".

The live_recording function only shows entries containing the term "live.

```{r}
coldplay_cleaned <- unique_songs(coldplay)
metallica_cleaned <- unique_songs(metallica)

coldplay_studio <- studio_recording(coldplay)
metallica_studio <- studio_recording(metallica)

coldplay_live <- live_recording(coldplay)
metallica_live <- live_recording(metallica)
```

While the dataset primarily comprises song data, one hypothesis to explore is the perfect correlation between a song’s success and the album’s popularity. If validated, focusing on album-level analysis could greatly streamline data processing. The following box plot illustrates the popularity distribution of songs per album.

```{r}

plot_popularity_distribution(coldplay_cleaned)
```

This function combines data from Coldplay and Metallica, adds an identifier column to distinguish between them, merges the data sets, and then groups and summarizes the number of releases by release date and band.

Both bands have extensive histories, but it’s intriguing to assess their current activity. The following plot illustrates the number of song releases per band over time.

```{r}

releases <- calculate_num_releases(coldplay_cleaned, metallica_cleaned)

plot_releases_over_time(releases)
```

This function merges charts and spotify_info datasets on song names, ensures unique entries by song, and assigns the result to charts_spotify. It then calculates the mean song duration per year and assigns this summary to charts_duration.

```{r}
create_charts_data(charts, spotify_info)
```

In recent years, a hypothesis has emerged that songs have become shorter for two reasons. Firstly, algorithms purportedly favor shorter songs, and secondly, the rise of social media values brief, impactful segments for video content. To test this theory and its applicability to Coldplay and Metallica, I will plot the song durations below.

```{r}
plot_duration_over_time(charts_spotify, coldplay_cleaned, metallica_cleaned)
```

Question 3

load data 

```{r}
alloc <- read.csv("Question3/data/Ukraine_Aid/Financial Allocations.csv")
commit <- read.csv("Question3/data/Ukraine_Aid/Financial Commitments.csv")
commit_clean <- commit %>% filter(!grepl("EU", Country))
```

Here are some basic statistics that illustrate the impact of EU membership on allocation and commitment levels.

```{r}

summary(lm(alloc$Total.bilateral.allocations...billion.~alloc$EU.member))
summary(lm(commit$Total.bilateral.commitments...billion.~commit$EU.member))
```


The plot_largest_contributors function identifies the top 10 countries by total bilateral commitments and visualizes them in a bar chart, distinguishing EU members with color coding.

```{r}

plot_largest_contributors(commit_clean)

```



Question 4

Load data sets

```{r}
winter <- readRDS("Question4/data/olympics/winter.rds")
summer <- readRDS("Question4/data/olympics/summer.rds")
gdp <- readRDS("Question4/data/olympics/GDP.rds")
```

If multiple individuals win more than one medal of each level in a single event, we need to filter out those individuals from the dataset.

```{r}
summer_cleaned <- clean_summer_data(summer, 2012)
```

Count the medals per country.

```{r}
country_medals <- summarize_country_medals(summer_cleaned)
```

Combine country medal data with country income and development level.

```{r}
gdp_medals <- merge(country_medals, gdp, by.x = "Country", by.y = "Code")
```

The plot_emerging_medals function filters gdp_medals data based on a specified GDP per capita threshold, computes the total medals won by each country meeting this criterion, and visualizes the results in a bar chart.

```{r}

summarize_and_plot_medals(gdp_medals, 3000)

```

Smaller economies may excel in the Olympics due to their higher concentration of resources per capita. To investigate this, I will plot medal counts relative to population size.

```{r}
plot_top_countries_medals(gdp_medals, 25)
```


I will now conduct a comparative analysis between the Winter and Summer Olympics, examining overall performance across all countries and all years.

Lets start with the winter olympics.

```{r}
    winter_medals <- winte %>%
        group_by(Event, Gender, Medal, Discipline, Year) %>%
        distinct(Event, Country, .keep_all = TRUE) %>%
        ungroup()
    

    country_medals_winter <- winter_medals %>%
        group_by(Country, Year) %>%
        count(Medal)
    

    winter_medals_total <- country_medals_winter %>%
        group_by(Country, Year) %>%
        summarise(Medals = sum(n)) %>%
        ungroup()
```

Same analysis for the summer

```{r}
summer_medals <- summer %>% group_by(Event, Gender, Medal, Discipline, Year) %>% 
    distinct(Event, Country, .keep_all = TRUE) %>% ungroup()

country_medals_summer <- summer_medals %>% group_by(Country,Year) %>% count(Medal)

summer_medals_total_year <- country_medals_summer %>% group_by(Country, Year) %>% 
    summarise(Medals = sum(n)) %>% ungroup()

summer_medals_total <- country_medals_summer %>% group_by(Country) %>% 
    summarise(Medals = sum(n)) %>% ungroup()
```

Lets investigate the most successful countries in the Summer Olympics

```{r}
summer_success <- summer_medals_total %>% arrange(desc(Medals)) %>% slice(1:10) %>% ungroup()
plot_summer_success(summer_success)
```


```{r}
time_series_winter <- merge(winter_medals_total, summer_success, by = "Country")

plot_time_series_winter(time_series_winter)
```

To determine if a country exceeds its expected performance in the Olympics, two key factors come into play: financial investment in training Olympic athletes, which is costly, and population size, as larger populations generally enhance the likelihood of success.

Medals per GDP

```{r}
gdp_medals$per_capita <- gdp_medals$n / gdp_medals$Population
per_capita_success <- gdp_medals %>% arrange(desc(per_capita)) %>% slice(1:10) %>% ungroup()

gdp_medals$per_gdp <- gdp_medals$n / gdp_medals$`GDP per Capita`
per_gdp_success <- gdp_medals %>% arrange(desc(per_gdp)) %>% slice(1:10) %>% ungroup()

```

```{r}
plot_per_gdp_success(per_gdp_success)
```

Plot of medals per Capita

```{r}
plot_per_capita_success(per_capita_success)
```

Question 5


connect to SQL database, find out table names and load data into r

```{r}
library(dbbasic)
library(DBI)

conn <- db_connect(db = "psql_datascience")
tables <- dbListTables(conn)
str(tables)
retailer <- db_query("SELECT * FROM retailer;", db = "psql_datascience")
statssa <- db_query("SELECT * FROM statssa;", db = "psql_datascience")
cpi_sa <- read.csv("Question5/data/Excel - CPI (COICOP) from January 2008 (202405).csv")
```

Plot the index data for each product.

```{r}
plot_ingredients(statssa)
```

Calculate average price of a bread and plot the average over time.

```{r}
index_braai_monthly <- calculate_average_index(ingredients)
long_braai_df <- long_braai(retailer)
plot_braai_price(long_braai_df)

```

Monthly average price of braaibroodje.

```{r}
braai_percent_change <- month_month_percentage(sum_price)
filtered_cpi <- filter_cpi_data(cpi_sa)
date <- transform_date(filtered_cpi)
filtered_cpi$month <- date
filtered_cpi$V1 <- as.numeric(unlist(filtered_cpi$V1))
cpi_perc <- sa_percentage_change(filtered_cpi, "V1")
```

I will then compare my Braaibroodjie index to the official CPI index. This comparison will help contextualize the specific inflationary impact on the braaibroodjie within the broader framework of general consumer price trends in South Africa.

```{r}
plot_braai_index_perc(index_braai_monthly, cpi_perc)
```









