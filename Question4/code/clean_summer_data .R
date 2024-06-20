clean_summer_data <- function(summer_data, year) {
    summer_cleaned <- summer_data %>%
        filter(grepl(year, Year)) %>%
        group_by(Event, Gender, Medal, Discipline) %>%
        distinct(Event, Country, .keep_all = TRUE) %>%
        ungroup()

    return(summer_cleaned)
}