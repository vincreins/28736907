plot_per_capita_success <- function(per_capita_success) {
    per_capita_success %>%
        ggplot(aes(x = reorder(Country, -per_capita), y = per_capita)) +
        geom_bar(stat = "identity", fill = "steelblue") +
        labs(x = "Country", y = "Medals per Capita", title = "Top 10 Countries by Medals per Capita") +
        theme_minimal()
}