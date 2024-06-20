sa_percentage_change <- function(data, column_name) {
    data <- data %>%
        mutate(diff_cpi = (get(column_name) - lag(get(column_name))) / lag(get(column_name)) * 100)

    return(data)
}
