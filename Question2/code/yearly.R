library(dplyr)

mean_duration_year <- function(data, duration_column, release_date_column) {
    result <- data %>%
        mutate(year = format({{release_date_column}}, "%Y")) %>%
        group_by(year) %>%
        summarise(mean_duration = mean({{duration_column}}, na.rm = TRUE)) %>%
        ungroup()

    return(result)
}