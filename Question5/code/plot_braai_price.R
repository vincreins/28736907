plot_braai_price <- function(long_braai_df) {
    sum_price <- long_braai_df %>%
        group_by(price_date) %>%
        summarise(prices = sum(prices))

    assign("sum_price", sum_price, envir = parent.frame())


    ggplot(sum_price, aes(x = price_date, y = prices)) +
        geom_line() + ggtitle("Cost of producing a braaibroodje over time")+
        xlab("Year") + ylab("ZAR")
}