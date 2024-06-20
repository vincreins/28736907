plot_top_pop_medals <- function(gdp_medals, top_n = 25) {

    largest_countries <- gdp_medals %>%
        arrange(desc(Population)) %>%
        slice(1:top_n) %>%
        ungroup()


    pop_medals <- largest_countries %>%
        group_by(Country) %>%
        summarise(Medals = sum(n)) %>%
        ungroup()


    p <- pop_medals %>%
        ggplot(aes(x = reorder(Country, -Medals), y = Medals, fill = Country == "IND")) +
        geom_bar(stat = "identity") +
        scale_fill_manual(values = c("FALSE" = "steelblue", "TRUE" = "orange")) +
        labs(x = "Country", y = "Total Medals", title = "Total Medals for Top Countries by Population") +
        theme_minimal()

    return(p)
}
