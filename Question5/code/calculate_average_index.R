calculate_average_index <- function(ingredients) {
    sum_index <- ingredients %>%
        group_by(date) %>%
        summarise(value = sum(value))

    sum_index_average <- sum_index %>%
        mutate(avg = value / 7) %>%
        mutate(month = format(date, "%Y-%m")) %>%
        mutate(perc_change = (avg - lag(avg)) / lag(avg) * 100)

    return(sum_index_average)
}