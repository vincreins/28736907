plot_per_gdp_success <- function(per_gdp_success) {
    per_gdp_success %>%
        ggplot(aes(x = reorder(Country, -per_gdp), y = per_gdp)) +
        geom_bar(stat = "identity", fill = "steelblue") +
        labs(x = "Country", y = "Medals per GDP", title = "Top 10 Countries by Medals per GDP") +
        theme_minimal()
}