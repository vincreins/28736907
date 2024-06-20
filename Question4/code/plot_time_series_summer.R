plot_time_series_summer <- function(time_series_summer) {
    time_series_summer %>%
        ggplot(aes(x = Year, y = Medals.x, color = Country, group = Country)) +
        geom_line() +
        geom_point() +
        labs(x = "Year", y = "Medals", title = "Time Series of Summer Olympics Medals by Country") +
        theme_minimal()
}
