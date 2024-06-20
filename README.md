---
title : "README
output: github_document
---

# Purpose

Purpose of this work folder.

Ideally store a minimum working example data set in data folder.

Add binary files in bin, and closed R functions in code. Human Readable settings files (e.g. csv) should be placed in settings/


```{r}

library(tidyr)
library(dplyr)
library(ggplot2)
library(tidyverse)

rm(list = ls()) # Clean your environment:
gc() # garbage collection - It can be useful to call gc after a large object has been removed, as this may prompt R to return memory to the operating system.
library(tidyverse)
list.files('Question 2/code/', full.names = T, recursive = T) %>% .[grepl('.R', .)] %>% as.list() %>% walk(~source(.))
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

load data
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

Load data 

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


plot popularity by album

```{r}

plot_popularity_distribution(coldplay_cleaned)
```

This function combines data from Coldplay and Metallica, adds an identifier column to distinguish between them, merges the datasets, and then groups and summarizes the number of releases by release date and band.

```{r}

releases <- calculate_num_releases(coldplay_cleaned, metallica_cleaned)

plot_releases_over_time(releases)
```


Investigate if song duration decreased over time because of streaming services, if this trend can be found with metallica and coldplay




This function merges charts and spotify_info datasets on song names, ensures unique entries by song, and assigns the result to charts_spotify. It then calculates the mean song duration per year and assigns this summary to charts_duration.

```{r}
create_charts_data(charts, spotify_info)
```



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

Some basic statistics which show the effect on the allocation/commitment of being a EU member state

```{r}

summary(lm(alloc$Total.bilateral.allocations...billion.~alloc$EU.member))
summary(lm(commit$Total.bilateral.commitments...billion.~commit$EU.member))
```


The plot_largest_contributors function identifies the top 10 countries by total bilateral commitments and visualizes them in a bar chart, distinguishing EU members with color coding.

```{r}

plot_largest_contributors(commit_clean)

```



Question 4

load data

```{r}
winter <- readRDS("Question4/data/olympics/winter.rds")
summer <- readRDS("Question4/data/olympics/summer.rds")
gdp <- readRDS("Question4/data/olympics/GDP.rds")
```


filter data

If in one event more than one medal of each level is won by more than one person,
we have to filter that person

```{r}
summer_cleaned <- clean_summer_data(summer, 2012)
```

Count the medals per country

```{r}
country_medals <- summarize_country_medals(summer_cleaned)
```

Combine country medal data with country income and development data

```{r}
gdp_medals <- merge(country_medals, gdp, by.x = "Country", by.y = "Code")
```

The plot_emerging_medals function filters gdp_medals data based on a specified GDP per capita threshold, computes the total medals won by each country meeting this criterion, and visualizes the results in a bar chart.

```{r}

summarize_and_plot_medals(gdp_medals, 3000)

```

Compared to country size

```{r}
plot_top_countries_medals(gdp_medals, 25)
```


Most dominant in Winter

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
time series winter




Most dominant in Summer

```{r}
summer_medals <- summer %>% group_by(Event, Gender, Medal, Discipline, Year) %>% 
    distinct(Event, Country, .keep_all = TRUE) %>% ungroup()

country_medals_summer <- summer_medals %>% group_by(Country,Year) %>% count(Medal)

summer_medals_total_year <- country_medals_summer %>% group_by(Country, Year) %>% 
    summarise(Medals = sum(n)) %>% ungroup()

summer_medals_total <- country_medals_summer %>% group_by(Country) %>% 
    summarise(Medals = sum(n)) %>% ungroup()
```
plot 
```{r}
summer_success <- summer_medals_total %>% arrange(desc(Medals)) %>% slice(1:10) %>% ungroup()
plot_summer_success(summer_success)
```


```{r}
time_series_winter <- merge(winter_medals_total, summer_success, by = "Country")

plot_time_series_winter(time_series_winter)
```
plot time series summer

```{r}
time_series_summer <- merge(summer_medals_total_year, summer_success, by = "Country")

plot_time_series_summer(time_series_summer)
```

To determine if a country exceeds its expected performance in the Olympics, two key factors come into play: financial investment in training Olympic athletes, which is costly, and population size, as larger populations generally enhance the likelihood of success.

Medals per capita

```{r}
gdp_medals$per_capita <- gdp_medals$n / gdp_medals$Population
per_capita_success <- gdp_medals %>% arrange(desc(per_capita)) %>% slice(1:10) %>% ungroup()

gdp_medals$per_gdp <- gdp_medals$n / gdp_medals$`GDP per Capita`
per_gdp_success <- gdp_medals %>% arrange(desc(per_gdp)) %>% slice(1:10) %>% ungroup()

```

```{r}
plot_per_gdp_success(per_gdp_success)
```

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

Plot the index data for each product

```{r}
plot_ingredients(statssa)
```

calculate average price of a bread and plot the average over time
```{r}
index_braai_monthly <- calculate_average_index(ingredients)
long_braai_df <- long_braai(retailer)
plot_braai_price(long_braai_df)

```

monthly price

```{r}
braai_percent_change <- month_month_percentage(sum_price)
filtered_cpi <- filter_cpi_data(cpi_sa)
date <- transform_date(filtered_cpi)
filtered_cpi$month <- date
filtered_cpi$V1 <- as.numeric(unlist(filtered_cpi$V1))
cpi_perc <- sa_percentage_change(filtered_cpi, "V1")
```


```{r}
plot_braai_index_perc(index_braai_monthly, cpi_perc)
```









