plot_time_series_winter <- function(time_series_winter) {
    time_series_winter %>%
        ggplot(aes(x = Year, y = Medals.x, color = Country, group = Country)) +
        geom_line() +
        geom_point() +
        labs(x = "Year", y = "Medals", title = "Time Series of Winter Olympics Medals by Country") +
        theme_minimal()
}