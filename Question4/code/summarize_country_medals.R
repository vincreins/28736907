summarize_country_medals <- function(summer_cleaned_data) {
    country_medals <- summer_cleaned_data %>%
        group_by(Country) %>%
        count(Medal)

    return(country_medals)
}