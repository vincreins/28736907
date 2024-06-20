plot_summer_success <- function(summer_success) {
    summer_success %>%
        ggplot(aes(x = reorder(Country, -Medals), y = Medals)) +
        geom_bar(stat = "identity") +
        labs(x = "Country", y = "Total Medals", title = "Top 10 Countries by Total Medals in Summer Olympics") +
        theme_minimal()
}