month_month_percentage <- function(sum_price) {
    avg_monthly_price <- sum_price %>%
        mutate(month = format(price_date, "%Y-%m")) %>%
        group_by(month) %>%
        summarise(avg_price = mean(prices)) %>%
        arrange(month) %>%
        mutate(braai_perc = (avg_price - lag(avg_price, 1)) / lag(avg_price, 1) * 100)

    return(avg_monthly_price)
}