summarize_and_plot_medals <- function(gdp_medals, gdp_cap_filter = 6000) {

    emerging_medals <- gdp_medals %>%
        filter(`GDP per Capita` <= gdp_cap_filter)

    assign("emerging_medals", emerging_medals, envir = parent.frame())


    total_medals <- emerging_medals %>%
        group_by(Country) %>%
        summarise(Medals = sum(n))
s

    p <- total_medals %>%
        ggplot(aes(x = reorder(Country, -Medals), y = Medals, fill = Country == "IND")) +
        geom_bar(stat = "identity") +
        scale_fill_manual(values = c("FALSE" = "steelblue", "TRUE" = "orange")) +
        labs(x = "Country", y = "Total Medals", title = "Total Medals by Country for GDP per Capita <= $6000") +
        theme_minimal()

    return(p)
}